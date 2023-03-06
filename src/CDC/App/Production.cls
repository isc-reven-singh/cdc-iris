Class CDC.App.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="CDC.App.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="CDC.Inbound.TCP" Category="" ClassName="CDC.Inbound.TCP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Port">6666</Setting>
  </Item>
  <Item Name="CDC.Outbound.TCP" Category="" ClassName="CDC.Outbound.TCP" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="IPAddress">localhost</Setting>
    <Setting Target="Adapter" Name="Port">6666</Setting>
  </Item>
  <Item Name="CDC.Listener" Category="" ClassName="CDC.Listener" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Database">"customerdb"</Setting>
    <Setting Target="Host" Name="DatabasePort">"3306"</Setting>
    <Setting Target="Host" Name="Host">"localhost"</Setting>
    <Setting Target="Host" Name="Password">root</Setting>
    <Setting Target="Host" Name="Table">"customer"</Setting>
    <Setting Target="Host" Name="Username">root</Setting>
  </Item>
  <Item Name="Ens.BusinessProcessBPL" Category="" ClassName="Ens.BusinessProcessBPL" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
