#include "State.h"


State::State()
{
	this->str_enter = StaticCString::create("enter");
	this->str_execute = StaticCString::create("execute");
	this->str_exit = StaticCString::create("exit");
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

void State::_bind_methods()
{
	ObjectTypeDB::bind_method("enter",&State::enter);
	ObjectTypeDB::bind_method("execute",&State::execute);
	ObjectTypeDB::bind_method("exit",&State::exit);
}
