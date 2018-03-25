#include <stdio.h>
#include<stdlib.h>
#include "Python.h"

extern "C" void interf2c(int *);//,double *,double *);
void PyInterface(){
     Py_Initialize();
        PyRun_SimpleString("import sys");
        PyRun_SimpleString("sys.path.append('./')");


     PyObject * pModule = NULL;
     PyObject * pFunc = NULL;
     pModule =PyImport_ImportModule("mypy");
//        printf("11111 %x\n",pModule);
     pFunc= PyObject_GetAttrString(pModule, "eval");
     PyEval_CallObject(pFunc, NULL);
     Py_Finalize();
}


//extern "C" void interf2c(int *);//,double *,double *);
int main(int argc, char** argv)

{

  int b=0;
  interf2c(&b);//,&grad[0],&hess[10000]);

  PyInterface();	
  return 0;

}

