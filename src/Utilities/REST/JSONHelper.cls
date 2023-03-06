Class Utilities.REST.JSONHelper
{

ClassMethod GetJSONFromRequest(request As %CSP.Request, Output obj As %DynamicObject) As %Boolean
{
	Set ok = 1
	Try {
		Set obj = ##class(%DynamicObject).%FromJSON(request.Content)
	} Catch ex {
		Set ok = 0
	}
	Quit ok
}

/// Description
ClassMethod RespondError(msg) As %Status
{
	S output = ##class(Messages.REST.Output).%New()
	Set output.Error = msg
	D output.%JSONExport()
	Quit $$$OK
}

}
