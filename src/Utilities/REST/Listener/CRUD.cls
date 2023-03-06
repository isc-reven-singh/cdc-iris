Class Utilities.REST.Listener.CRUD
{

ClassMethod CreateListener(jsonObj) As REST.Messages.Output
{
        Set sc = $$$OK
        // do something
        S msg = ##class(CDC.Listener.Entity).%New()
        S sc = msg.%JSONImport(jsonObj) 
        S output = ##class(REST.Messages.Output).%New()
        S err = 0
        //Validate input
        If msg.Name = ""
        {
            S output.Error = output.Error_"Name field cannot be found."
            s err = $I(err)
        }

        //Check if Data Dictionary name already exists
        &sql(SELECT COUNT(Name),COUNT(ServerId) INTO :existingNames,:existingServerIds FROM CDC_Listener.Entity
        WHERE Name = :msg.Name
        OR ServerId = :msg.ServerId)

        If existingNames > 0
        {
            S output.Error = output.Error_"A listener already exists with the name '"_msg.Name_"'."
           s err = $I(err)
        }

        If existingServerIds > 0
        {
            S output.Error = output.Error_"A listener already exists with the server id '"_msg.ServerId_"'."
           s err = $I(err)
        }

        //Save data dictionary
        If err = 0
        {
        S sc = msg.%Save()
        S sc = ##class(Utilities.Listener).AddListener(msg)
        If $$$ISOK(sc)
        {
            S output.Message = output.Error_"New Listener Created Successfully."
        }
        Else
        {
            S output.Error = sc
        }
        }

        Return output
}

/// Description
ClassMethod StartListener(jsonObj) As REST.Messages.Output
{
    Set sc = $$$OK
    // do something
    Set sc = $$$OK
        // do something
        S msg = ##class(REST.Messages.StartStopListener).%New()
        S sc = msg.%JSONImport(jsonObj) 
        S output = ##class(REST.Messages.Output).%New()

        //Validate input
        If msg.Name = ""
        {
            S output.Error = "Name field cannot be found."
            Return output
        }

            s javaGate = $system.external.getJavaGateway()

    s orchestrator = javaGate.invoke("com.cdc.app.Orchestrator","getInstance")
    d orchestrator.startListener(msg.Name)

        //Save data dictionary


        S output.Message = "Listener "_msg.Name_" Started Successfully."
        Return output
    Return sc
}

ClassMethod StopListener(jsonObj) As REST.Messages.Output
{
    Set sc = $$$OK
    // do something
    Set sc = $$$OK
        // do something
        S msg = ##class(REST.Messages.StartStopListener).%New()
        S sc = msg.%JSONImport(jsonObj) 
        S output = ##class(REST.Messages.Output).%New()

        //Validate input
        If msg.Name = ""
        {
            S output.Error = "Name field cannot be found."
            Return output
        }

            s javaGate = $system.external.getJavaGateway()

    s orchestrator = javaGate.invoke("com.cdc.app.Orchestrator","getInstance")
    d orchestrator.stopListener(msg.Name)

        //Save data dictionary


        S output.Message = "Listener "_msg.Name_" Stopped Successfully."
        Return output
    Return sc
}

}
