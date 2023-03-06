Class Utilities.Listener
{

/// Description
ClassMethod AddListener(listener As CDC.Listener.Entity) As %Status
{
        Set sc = $$$OK
        // do something
        s javaGate = $system.external.getJavaGateway()

        s orc = javaGate.invoke("com.cdc.app.Orchestrator","getInstance")

        w orc.getInfo()

        d orc.addListener(listener.Name, 
        listener.TCPHost, 
        listener.TCPPort,
        listener.DatabaseHost,
        listener.Database,
        listener.Table,
        listener.DatabasePort,
        listener.DatabaseUser,
        listener.DatabasePass,
        listener.ServerId)
        Return sc
}

}
