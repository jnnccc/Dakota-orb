def eval():
    import numpy as np
    from ctypes import (CDLL, POINTER, ARRAY, c_void_p,
                        c_int, byref,c_double, c_char,
                        c_char_p, create_string_buffer)
    from numpy.ctypeslib import ndpointer
    libtest = CDLL("./libusrdefine.so")
    shape1=(1000)
    shape2=(10000)
    c_int_p = POINTER(c_int)
#    c_double_p = POINTER(c_double)
    c_double_grad = ndpointer(shape=shape1, dtype="double", flags="FORTRAN")
    c_double_hess = ndpointer(shape=shape2, dtype="double", flags="FORTRAN")
    init = libtest.interf2c
    init.argtypes=[c_int_p,c_double_grad,c_double_hess]
    arg2 = np.zeros(shape1, order="F") 
    arg3 = np.zeros(shape2, order="F") 
    init.restype = None
    arg1 = c_int(1)
    init(byref(arg1),arg2,arg3)
    print arg2[1:10]
