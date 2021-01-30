#ifndef GDINKCPP_H
#define GDINKCPP_H

#include <Godot.hpp>
#include <Reference.hpp>

#include <fstream>
#include <vector>
#include <sstream>
#include <regex>

#include <story.h>
#include <runner.h>
#include <compiler.h>
#include <choice.h>
#include <globals.h>

namespace godot {

class InkCpp : public Reference {
    GODOT_CLASS(InkCpp, Reference)

public:
    String path;
    static void _register_methods();

    InkCpp();
    ~InkCpp();

    void _init();

    int play_story();
};

}

#endif
