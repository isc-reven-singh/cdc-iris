Class CDC.Outbound.TCP Extends Ens.BusinessOperation
{

// Parameter ADAPTER = "EnsLib.TCP.TextLineOutboundAdapter";

// Property Adapter As EnsLib.TCP.TextLineOutboundAdapter;

Parameter INVOCATION = "Queue";

Method Acknowledge(pReq As Ens.StringContainer, Output pResponse As Ens.StringContainer) As %Status
{
  Set str= pReq.StringValue
  $$$TRACE("received line "_str)
      
  set obj = ##class(%DynamicAbstractObject).%FromJSON(str)
  Set msg=##class(CDC.Message.DebeziumChangeRecord).%New()
  Set source = ##class(CDC.Message.DebeziumSource).%New()
  d source.%JSONImport(obj.source)
  s msg.source = source

  $$$TRACE("Source : "_source.db_"."_source.table)
  Set MessageClass = source.db_"."_source.table
  s response = ""


  //Deserialize JSON input to a master message object
  s before = 0
  s after = 0
  if (obj.before)
  {
    Set before = 1
    S bcust = $CLASSMETHOD(MessageClass,"%New")
    d bcust.%JSONImport(obj.before)
    Set msg.before = bcust}
  
  if (obj.after)
  { 
    Set after = 1
    S acust = $CLASSMETHOD(MessageClass,"%New")
    d acust.%JSONImport(obj.after)
    Set msg.after = acust}
  
  if (obj.op)
  {Set msg.op = obj.op}
  
  if (obj."ts_ms")
  {Set msg.tsms = obj."ts_ms"}

  //Check transaction type
  S create = 'before & after
  S update = before & after
  S delete = before & 'after

  if (create)
  {
    $$$TRACE("data after")
    S entity = $CLASSMETHOD(MessageClass,"%New")
    set entity = msg.after
    set sc = entity.%Save()
    if $$$ISOK(sc)
    {
      s response = "Record created successfully in "_MessageClass
    }
  }

  if (update)
  {
    $$$TRACE("updating ... id before : "_msg.before.id)
    set entity = $CLASSMETHOD(MessageClass,"%OpenId",msg.before.id)


    set result = ##class(%SQL.Statement).%ExecDirect(, "select Name,Type,Origin from %Dictionary.CompiledProperty where parent = ? AND Origin = ?",
        MessageClass,MessageClass)
    if result.%SQLCODE < 0 {
        throw ##class(%Exception.SQL).CreateFromSQLCODE(result.%SQLCODE,result.%Message)
    }
    while result.%Next() {
       
        S $PROPERTY(entity,result.Name) = $PROPERTY(msg.after,result.Name)
        $$$TRACE("Setting "_$PROPERTY(entity,result.Name)_" = "_$PROPERTY(msg.after,result.Name))
       
    }


    $$$TRACE("get fullname : "_$PROPERTY(msg.after,"fullname"))

    $$$TRACE("updated ... fullname after : "_msg.after.fullname)
    set sc = entity.%Save()
    $$$TRACE("update status : "_sc)

    if $$$ISOK(sc)
    {
      s response = "Record updated successfully in "_MessageClass
    }
  }

  if (delete)
  {
    set sc = $CLASSMETHOD(MessageClass,"%DeleteId",msg.before.id)
    if $$$ISOK(sc)
    {
      s response = "Record deleted successfully in "_MessageClass
    }
  }
  
  
  $$$TRACE("imported obj : "_msg)
  
    set pResponse=##class(Ens.StringContainer).%New()
    set pResponse.StringValue=response
 // Set pResponse = str
  
  //Set tSC = ..Adapter.SendMessageString(str)
  Quit $$$OK
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Ens.StringContainer">
    <Method>Acknowledge</Method>
  </MapItem>
</MapItems>
}

}
