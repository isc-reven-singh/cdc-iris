Class CDC.Message.DebeziumChangeRecord Extends (%RegisteredObject, %JSON.Adaptor, Ens.Response)
{

Parameter %JSONIGNOREINVALIDFIELD = 1;

Property before As customerdb.customer;

Property after As customerdb.customer;

Property source As customerdb.Message.DebeziumSource;

Property op As %String;

Property tsms As %Integer(%JSONFIELDNAME = "ts_ms");

}
