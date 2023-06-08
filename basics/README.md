# swd_journey_flutter

A new Flutter project.

Flutter is a tool that allows you to build native cross platform(iOS, Android) apps with one programming language and codebase.

We use Flutter Create "the name of the projects" to create flutter code
The lib folder is a very important file that takes all the main dart code. Also the file in this folder must end with .dart
The runApp is a function and it is use to start building an app. It is use to show user interface of our App.
main function - normally a functions needs to be called but the main function is the entry point of a flutter apps so it doesnt needs to be called at all. Inside of the main function we need to call the runApp.
Widget - we need to put in some widget in our code to start up our flutter App. This is called the MaterialApp.
Named and postional argument -
Positional: The position of an argument determines which parameter receives the value

void add(a, b) { // a & b are positional parameters
print(a + b); // print() is a built-in function that will be explained later
}

add(5, 10); // 5 is used as a value for a, because it's the first argument; 10 is used as a value for b
Named: The name of an argument determines which parameter receives the value

void add({a, b}) { // a & b are named parameters (because of the curly braces)
print(a + b);
}

add(b: 5, a: 10); // 5 is used as a value for b, because it's assigned to that name; 10 is used as a value for a

Scaffold - The Scaffold widget helps us set up a good looking screen in the MaterialApp

MaterialApp is the root widget that helps us startup the screen overwiew

Container - This is helps us with more styling and confuguration.

Class - helps us take a particular UI or code to be used called with the name.
Variables - this are data containers
