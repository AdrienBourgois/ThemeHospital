#include "StateMachine.h"


StateMachine::StateMachine()
{
	this->owner = NULL;
	this->current_state = NULL;
	this->previous_state = NULL;
}

StateMachine::~StateMachine()
{
	this->owner = NULL;
    this->current_state = NULL;
    this->previous_state = NULL;
}

void StateMachine::setOwner(Node* new_owner)
{
	this->owner = new_owner;
}

void StateMachine::update()
{
	if (this->current_state && this->owner)
		this->current_state->execute(this->owner);
	else
		ERR_EXPLAIN("Update can't be use without current state and owner.");
	
	ERR_FAIL_COND(!this->owner);
	ERR_FAIL_COND(!this->current_state);
}

void StateMachine::setCurrentState(Node* n)
{
	if (this->owner)
	{
		this->current_state = dynamic_cast<State*>(n);
		this->current_state->enter(this->owner);
	}
	else
		ERR_EXPLAIN("setCurrentState can't be use without owner.");

	ERR_FAIL_COND(!this->owner);
}

void StateMachine::changeState(Node* n)
{
	if (this->owner)
	{
		if (this->current_state)
		{
			this->current_state->exit(this->owner);
			this->previous_state = this->current_state;
		}
		else
			ERR_EXPLAIN("changeState can't be use without current state.");
		ERR_FAIL_COND(!this->current_state);

		this->current_state = dynamic_cast<State*>(n);

		this->current_state->enter(this->owner);
	}
	else
		ERR_EXPLAIN("changeState can't be use without owner.");

	ERR_FAIL_COND(!this->owner);
}

void StateMachine::returnToPreviousState()
{
	if (this->previous_state)
		this->changeState(this->previous_state);
	else
		ERR_EXPLAIN("ReturnToPreviousState can't be use without a current state and an owner.");

	ERR_FAIL_COND(!this->previous_state);
}

void StateMachine::setCurrentStateName(String new_name)
{
	this->current_state->setName(new_name);
}

String StateMachine::getCurrentStateName() const
{
	return this->current_state->getName();
}

void StateMachine::_bind_methods()
{
	ObjectTypeDB::bind_method("setOwner",&StateMachine::setOwner);
	ObjectTypeDB::bind_method("getOwner",&StateMachine::getOwner);
	ObjectTypeDB::bind_method("update",&StateMachine::update);
	ObjectTypeDB::bind_method("setCurrentState",&StateMachine::setCurrentState);
	ObjectTypeDB::bind_method("changeState",&StateMachine::changeState);
	ObjectTypeDB::bind_method("returnToPreviousState",&StateMachine::returnToPreviousState);

	ObjectTypeDB::bind_method("setCurrentStateName",&StateMachine::setCurrentStateName);
	ObjectTypeDB::bind_method("getCurrentStateName",&StateMachine::getCurrentStateName);
}
