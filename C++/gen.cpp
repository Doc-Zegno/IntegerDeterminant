#include <cstdlib>
#include <iostream>
#include <ctime>
#include <string>
#include <stdexcept>


const int AMP = 100;
 
int main(int argc, char* argv[])
{
    try {
        if (argc < 2) {
            throw std::runtime_error("not enough arguments: matrix's side was expected");
        } 
        auto n = std::stoi(argv[1]);

        auto amp = AMP;
        if (argc >= 3) {
            amp = std::stoi(argv[2]);
        }
        auto shift = amp / 2;

        std::srand(unsigned(std::time(0)));
        std::cout << n << std::endl;
        for (auto i = 0; i < n; i++) {
            for (auto j = 0; j < n; j++) {
                auto value = std::rand() % amp - shift;
                std::cout << value << ' ';
            }
            std::cout << std::endl;
        }
                
    } catch (std::exception& e) {
        std::cout << e.what() << std::endl;
    }
}
