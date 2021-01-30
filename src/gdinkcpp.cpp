#include "gdinkcpp.h"

using namespace godot;

void InkCpp::_register_methods()
{
    register_method("play_story", &InkCpp::play_story);

    register_property<InkCpp, String>("path", &InkCpp::path, "default");
}

InkCpp::InkCpp()
{
}

InkCpp::~InkCpp()
{
}

void InkCpp::_init()
{
    path = String("default");
}

int InkCpp::play_story()
{

    std::string outputFilename;
    std::string inputFilename = path.alloc_c_string();

	// If output filename not specified, use input filename as guideline
	if (outputFilename.empty())
	{
		outputFilename = std::regex_replace(inputFilename, std::regex("\\.[^\\.]+$"), ".bin");
	}

    // Open file and compile
	{
		ink::compiler::compilation_results results;
		std::ofstream fout(outputFilename, std::ios::binary | std::ios::out);
		ink::compiler::run(inputFilename.c_str(), fout, &results);
		fout.close();

		// Report errors
		for (auto& warn : results.warnings)
			std::cerr << "WARNING: " << warn << '\n';
		for (auto& err : results.errors)
			std::cerr << "ERROR: " << err << '\n';

		if (results.errors.size() > 0)
		{
			std::cerr << "Cancelling play mode. Errors detected in compilation" << std::endl;
			return -1;
		}
	}

	// Run the story
	{
		using namespace ink::runtime;

		// Load story
		story* myInk = story::from_file(outputFilename.c_str());

		// Start runner
		runner thread = myInk->new_runner();

		while (true)
		{
			while (thread->can_continue())
				std::cout << thread->getline();

			if (thread->has_choices())
			{
				int index = 1;
				for (const ink::runtime::choice& c : *thread)
				{
					std::cout << index++ << ": " << c.text() << std::endl;
				}

				int c = 0;
				std::cin >> c;
				thread->choose(c - 1);
				std::cout << "?> ";
				continue;
			}

			// out of content
			break;
		}

		return 0;
	}
}