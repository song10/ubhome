#define BUILDING_NODE_EXTENSION
#include <node.h>
#include "myobject.h"

using namespace v8;

Handle<Value> CreateObject(const Arguments& args) {
  HandleScope scope;
  return scope.Close(MyObject::NewInstance(args));
}

Handle<Value> Add(const Arguments& args) {
  HandleScope scope;

  MyObject* obj1 = node::ObjectWrap::Unwrap<MyObject>(
      args[0]->ToObject());
  MyObject* obj2 = node::ObjectWrap::Unwrap<MyObject>(
      args[1]->ToObject());

  double sum = obj1->Val() + obj2->Val();
  return scope.Close(Number::New(sum));
}

void InitAll(Handle<Object> target) {
  MyObject::Init();

  target->Set(String::NewSymbol("createObject"),
      FunctionTemplate::New(CreateObject)->GetFunction());

  target->Set(String::NewSymbol("add"),
      FunctionTemplate::New(Add)->GetFunction());
}

NODE_MODULE(addon, InitAll)
