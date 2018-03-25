# Dakota as a solver for planetary radio science

#### Author
+ Nianchuan Jian
+ jnnccc@shao.ac.cn

#### project planning
+ project name: Dakota based planetary radio science research framework 
+ The aim of project is to build a general framework for planetary radio science research. Framework include solver based on Dakota(http://dakota.sandia.gov/) 
, modules(built-in) called by simulators and simulators which composed by researchers themselves. Motive of this work is that there exist many software for radio science
research like GeodynII, Gmat, utopia, Mont etc. Each of these software has it's own solver, data supplier and simulator and is very complex and huge.
The maintenance is a difficult job for these software. If there exists a general framework researcher need only  compose a simulator to do their work.



#### Dakota introduction
The Dakota project delivers both state-of-the-art research and robust, usable software for optimization and UQ. Broadly, the Dakota software's advanced parametric analyses enable design exploration, model calibration, risk analysis, and quantification of margins and uncertainty with computational models. The Dakota toolkit provides a flexible, extensible interface between such simulation codes and its iterative systems analysis methods, which include:
+ optimization with gradient and nongradient-based methods;
+ uncertainty quantification with sampling, reliability, stochastic expansion, and epistemic methods;
+ parameter estimation using nonlinear least squares (deterministic) or Bayesian inference (stochastic); and
+ sensitivity/variance analysis with design of experiments and parameter study methods.
  These capabilities may be used on their own or as components within advanced strategies such as hybrid optimization, surrogate-based optimization, mixed integer nonlinear programming, or optimization under uncertainty.
more information see http://dakota.sandia.gov/

#### Main modules
+ spice/naif
+ sofa
+ GPS module
...

#### Planetary radio science research(from NASA site) 
Planetary radio science focuses on the use of radio signals traveling between spacecraft and an Earth terminal for scientific investigation of planets and their environs. These signals provide an extremely precise measurement of the radio path between the ground station and the spacecraft, and such measurements in turn are employed to infer important characteristics of planetary systems. The technique is applied to the study of planetary atmospheres (including ionospheres), rings, surfaces and gravity. Much of our fundamental knowledge of these subjects has been derived from radio science observations. Examples of recent and current radio science investigations are those conducted with Voyager (Eshleman et al. 1977; Tyler, 1987), Galileo (Howard et al., 1992) and Mars Observer (Tyler et al., 1992). Earlier missions which incorporated radio science investigations included the Mariners, Pioneers and Viking, as well as Soviet missions.
Radio science experiments fall into two broad categories of investigation. First, for the study of planetary environments, the orbit or trajectory of the spacecraft is arranged so that the spacecraft passes behind the planetary body as seen from the tracking station on the Earth. In this case the spacecraft is said to be occulted by the planet. In the Saturn occultation experiments with Voyager 1, for example, the spacecraft, when approaching Saturn, flew behind the satellite Titan and then, about 18 h later, passed behind the ball of Saturn itself and finally, after emerging from behind Saturn, passed behind Saturn's rings (Stone and Miner, 1981). In the occulted intervals radio signals were not blocked entirely, but passed through the atmospheres of Titan and Saturn, and through the rings before being received on Earth (Figure R18). During occultation events one’ senses’ the media of interest — atmospheres or rings — by use of the radio signal as an active probe (Eshleman, 1973). The geometry and other experimental conditions must be controlled so that the only unknown factors are the properties of the medium along the radio path. Changes in the radio signals that are not associated with known factors are used to infer the properties of the unknown medium. 

#### data flow and interface
Below is a example of orbit determination flow chart
```
   +-----------+                                                                
   |observables|                                                                
   +-----+-----+                              +---------------------+           
         |                                    |   +--------------+  |           
         |  +---------(((---------------------+---+ data supplier|  |           
         |  |                                 |   +--------------+  |           
         |  |                                 |          |          |           
         |  |                                 |          |          |           
    +----+--+--+          +---------+         | +--------+--------+ |           
    |  Dakota  +---)))--- | Python  +--|      + |orbit integration| |           
    +----------+          +---------+  |      | +--------+--------+ |           
    |NLS/SA/UQ |                       |      |          |          |           
    +----------+                      ///     |          |          |           
    | output   |                       |      |     +----+------+   |           
    | and data |                       +------+-----+ simulator |   |           
    | plot     |                              |     +-----------+   |           
    +----------+                              |                     |           
    |C++ build |                              |Fortran shared Module|           
    +----------+                              +---------------------+           
                                                                                
notes:                                                                                                                                         
Dakota --------- Framework of solver with capability of parameter solver, solution sensitivity analysis and uncertainty quantification         
simulator------- compute theory observables , gradient vector, Hessian matrix(optional) at input parameter point. runing with parallel mode    
data supplier--- auxiliary data preparation for simulator including simulator running control parameter and planetary physical data(spice) ,planets ephemeris ,       
                 earth eop parameters, and time information etc.                                                                               
)))------------- exchange data of computed observables, gradient vector and hessian matrix (internal link through built-in script)                                     
(((------------- remind supplier to run at the initial run, just run once(iso c bind interface)[call from buit-in python interface is failed]                            
///------------- exchange data of computed observables, gradient vector and hessian matrix (iso c bind interface)                                         
NLS------------- non-linear squared method such as NL2SOL or NPSOL-QP 
SA-------------- Sensitive analysis                                                                                                            
UQ-------------- Uncertainty Quantification           
```

#### capabilities plan list
+ orbit determination (ongoing, for mars case)
+ saturn's ring study (ongoing)
+ planetary gravity recovery (planing)
+ planetary atmosphere and inosphere research (planing)
+ geodsy VLBI(very long base line reseaarch) research (future planing)
Reference:
@ARTICLE{asmar1993deep,
  author = {Asmar, SW and Renzetti, NA},
  title = {The Deep Space Network as an instrument for radio science research},
  year = {1993},
  volume = {95},
  pages = {21456},
  journal = {NASA STI/Recon Technical Report N}
}


#### work todo 
+ By now data supplier is successfully called from main.cpp of Dakota which is a dirty method I think. If it can be called form python script that will be better.
But there exist a well known memory leakage problem when C++ call built-in Python with third part module.
+ add DE(differential evolution algorithm) to Dakota optimization method list
+ module wrapper(many module application are written in f77 format. When simulator call functions with same name in different modules There will be a conflict)


