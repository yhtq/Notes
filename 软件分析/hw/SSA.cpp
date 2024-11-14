#include <iostream>
int main()
{
    int* a;
    for (int i = 0; i < 10; i++)
    {
        a = new int;
    }
    std::cout << &a << std::endl;
    delete a;
    return 0;
}