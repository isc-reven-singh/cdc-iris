Class CDC.Inbound.TCP Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.TCP.TextLineInboundAdapter";

Method OnProcessInput(pInput As Ens.StringContainer, Output pOutput As Ens.StringContainer) As %Status
{
    set tSubject = pInput.StringValue
    $$$TRACE("received line "_tSubject)

    set pOutput=##class(Ens.StringContainer).%New()
    set pOutput.StringValue=tSubject
    
    //set st = ..SendRequestSync("CDC.Outbound.TCP", pOutput, .resp)
    set st = ..SendRequestAsync("CDC.Outbound.TCP", pOutput)

	Quit $$$OK
}

}
