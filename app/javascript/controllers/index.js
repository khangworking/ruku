// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller

import { application } from "./application";

import HelloController from "./hello_controller";
import InfinitedScrolling from "./infinited_srolling_controller";
import ChatMessages from "./chat_messages_controller";
import Chats from "./chats_controller";
application.register("hello", HelloController);
application.register("infinited-scrolling", InfinitedScrolling);
application.register("chat-messages", ChatMessages);
application.register("chats", Chats);
