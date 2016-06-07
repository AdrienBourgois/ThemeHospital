#include "State.h"


State::State()
{
	this->str_enter = StaticCString::create("enter");
	this->str_execute = StaticCString::create("execute");
	this->str_exit = StaticCString::create("exit");
	this->name = "";
}

State::~State()
{}

void State::enter(Node* n)
{
	if (get_script_instance())
    	get_script_instance()->call(str_enter, n);
}

void State::execute(Node* n)
{
	if (get_script_instance())
		get_script_instance()->call(str_execute, n);
}

void State::exit(Node* n)
{
	if (get_script_instance())
    	get_script_instance()->call(str_exit, n);
}

void State::setName(String new_name)
{
	this->name = new_name;
}

String State::getName() const
{
	return this->name;
}

void State::_bind_methods()
{
	ObjectTypeDB::bind_method("enter",&State::enter);
	ObjectTypeDB::bind_method("execute",&State::execute);
	ObjectTypeDB::bind_method("exit",&State::exit);

	ObjectTypeDB::bind_method("setName",&State::setName);
	ObjectTypeDB::bind_method("getName",&State::getName);

	ADD_PROPERTYNZ( PropertyInfo( Variant::STRING, "name",PROPERTY_HINT_MULTILINE_TEXT,"",PROPERTY_USAGE_DEFAULT_INTL), _SCS("setName"),_SCS("getName") );
}
