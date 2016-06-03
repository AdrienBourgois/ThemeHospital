#ifndef __STATE_H_INCLUDED__
#define __STATE_H_INCLUDED__


#include "scene/main/node.h"
#include "string_db.h"


	class State
	: public Node
	{
		OBJ_TYPE(State,Node);

		public:
			State();
			~State();

			void enter(Node*);
			void execute(Node*);
			void exit(Node*);

		protected:
			static void _bind_methods();

		private:
			StringName str_enter;
			StringName str_execute;
			StringName str_exit;
	};

#endif
