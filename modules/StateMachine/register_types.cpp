#include "register_types.h"
#include "object_type_db.h"
#include "State.h"
#include "StateMachine.h"


void register_StateMachine_types() 
{
	ObjectTypeDB::register_type<State>();
	ObjectTypeDB::register_type<StateMachine>();
}

void unregister_StateMachine_types() 
{
}
