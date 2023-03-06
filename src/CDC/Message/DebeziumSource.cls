Class CDC.Message.DebeziumSource Extends (%RegisteredObject, %JSON.Adaptor)
{

Property version As %String(%JSONFIELDNAME = "version");

Property connector As %String(%JSONFIELDNAME = "connector");

Property name As %String(%JSONFIELDNAME = "name");

Property tsms As %Integer(%JSONFIELDNAME = "ts_ms");

Property snapshot As %String(%JSONFIELDNAME = "snapshot");

Property db As %String(%JSONFIELDNAME = "db");

Property table As %String(%JSONFIELDNAME = "table");

Property serverid As %Integer(%JSONFIELDNAME = "server_id");

Property file As %String(%JSONFIELDNAME = "file");

Property pos As %Integer(%JSONFIELDNAME = "pos");

Property row As %Integer(%JSONFIELDNAME = "row");

Parameter %JSONIGNOREINVALIDFIELD = 1;

}
