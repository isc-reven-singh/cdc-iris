Class REST.Dispatch.Listener Extends %CSP.REST
{

/// Default the Content-Type for this application.
Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/test" Method="GET" Call="Test" />
  <Route Url="/add" Method="POST" Call="Add" />
  <Route Url="/listeners" Method="GET" Call="GetListeners" />
    <Route Url="/startlistener" Method="POST" Call="StartListener" />
      <Route Url="/stoplistener" Method="POST" Call="StopListener" />
</Routes>
}

ClassMethod Test() As %Status
{
    Set sc = $$$OK
    // do something
    s output = { "status" : "success" }
    w output.%ToJSON()
    Return sc
}

ClassMethod Add() As %Status
{
  ///########################BOILERPLATE#####################################

    Set sc = ##class(Utilities.REST.JSONHelper).GetJSONFromRequest(%request,.obj)
    
    	If '$D(obj) {
        	Set %response.Status = ..#HTTP400BADREQUEST
          Set sc = ##class(Utilities.REST.JSONHelper).RespondError("JSON not found, or JSON document is incorrect")
          Quit $$$OK
	      }
 
  ///#########################################################################

    S response = ##class(Utilities.REST.Listener.CRUD).CreateListener(obj)
    D response.%JSONExport()
  
    Return sc
}

/// Description
ClassMethod GetListeners() As %Status
{
    Set sc = $$$OK
    // do something
    /*     Set listeners = ##class(CDC.Listener.Listeners).%New()
    s listener = listeners.listeners
    s i = 0

    D listeners.listeners.%JSONExportToString(.jsonString)
    w jsonString */

    s jstr = ##class(CDC.Listener.Entity).GetJsonListeners()
    w jstr

    Return sc
}

/// Description
ClassMethod StartListener() As %Status
{
///########################BOILERPLATE#####################################

    Set sc = ##class(Utilities.REST.JSONHelper).GetJSONFromRequest(%request,.obj)
    
    	If '$D(obj) {
        	Set %response.Status = ..#HTTP400BADREQUEST
          Set sc = ##class(Utilities.REST.JSONHelper).RespondError("JSON not found, or JSON document is incorrect")
          Quit $$$OK
	      }
 
  ///#########################################################################

    S response = ##class(Utilities.REST.Listener.CRUD).StartListener(obj)
    D response.%JSONExport()
  
    Return sc
}

ClassMethod StopListener() As %Status
{
///########################BOILERPLATE#####################################

    Set sc = ##class(Utilities.REST.JSONHelper).GetJSONFromRequest(%request,.obj)
    
    	If '$D(obj) {
        	Set %response.Status = ..#HTTP400BADREQUEST
          Set sc = ##class(Utilities.REST.JSONHelper).RespondError("JSON not found, or JSON document is incorrect")
          Quit $$$OK
	      }
 
  ///#########################################################################

    S response = ##class(Utilities.REST.Listener.CRUD).StopListener(obj)
    D response.%JSONExport()
  
    Return sc
}

}
