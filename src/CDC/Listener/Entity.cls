Class CDC.Listener.Entity Extends (%Persistent, %JSON.Adaptor)
{

Property Name As %String(%JSONFIELDNAME = "name");

Property Type As %String(%JSONFIELDNAME = "type");

Property TCPHost As %String(%JSONFIELDNAME = "tcphost");

Property TCPPort As %Integer(%JSONFIELDNAME = "tcpport");

Property DatabaseHost As %String(%JSONFIELDNAME = "databasehost");

Property DatabasePort As %String(%JSONFIELDNAME = "databaseport");

Property DatabaseUser As %String(%JSONFIELDNAME = "databaseuser");

Property DatabasePass As %String(%JSONFIELDNAME = "databasepass");

Property Database As %String(%JSONFIELDNAME = "database");

Property Table As %String(%JSONFIELDNAME = "table");

Property ServerId As %String(%JSONFIELDNAME = "serverid");

Property Status As %String(%JSONFIELDNAME = "status");

/// Description
ClassMethod GetJsonListeners() As %String
{
    Set sc = $$$OK
    // do something
    s jstr = "["
    // do something
    &sql(SELECT %DLIST(ID) INTO :id FROM CDC_Listener.Entity)
    //set formatter = ##class(%JSON.Formatter).%New()
      SET i=0
   WHILE $LISTNEXT(id,i,value) {
      s entity = ##class(CDC.Listener.Entity).%OpenId(value)
      d entity.%JSONExportToString(.ent)
      s jstr = jstr_ent_","

   }
    s jstr = $EXTRACT(jstr,0,$LENGTH(jstr)-1)_"]"
   // do formatter.Format(jstr)
    Return jstr
}

Storage Default
{
<Data name="EntityDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Type</Value>
</Value>
<Value name="4">
<Value>TCPHost</Value>
</Value>
<Value name="5">
<Value>TCPPort</Value>
</Value>
<Value name="6">
<Value>DatabaseHost</Value>
</Value>
<Value name="7">
<Value>DatabasePort</Value>
</Value>
<Value name="8">
<Value>DatabaseUser</Value>
</Value>
<Value name="9">
<Value>DatabasePass</Value>
</Value>
<Value name="10">
<Value>Database</Value>
</Value>
<Value name="11">
<Value>Table</Value>
</Value>
<Value name="12">
<Value>ServerId</Value>
</Value>
<Value name="13">
<Value>Status</Value>
</Value>
</Data>
<DataLocation>^CDC.Listener.EntityD</DataLocation>
<DefaultData>EntityDefaultData</DefaultData>
<IdLocation>^CDC.Listener.EntityD</IdLocation>
<IndexLocation>^CDC.Listener.EntityI</IndexLocation>
<StreamLocation>^CDC.Listener.EntityS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
