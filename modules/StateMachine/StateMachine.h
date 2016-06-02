#ifndef __STATEMACHINE_H_INCLUDED__
#define __STATEMACHINE_H_INCLUDED__

#include "scene/main/node.h"
#include "State.h"

	class StateMachine
	: public Node
	{
		OBJ_TYPE(StateMachine,Node);

		public:
			StateMachine();
			void setOwner(Node*);
			Node* getOwner() const { return this->owner; }
			void update();
			void setCurrentState(Node*);
			void changeState(Node*);
			void returnToPreviousState();

		protected:
			static void _bind_methods();

		private:
			Node* owner;
			State* current_state;
			State* previous_state;
	};


#endif
