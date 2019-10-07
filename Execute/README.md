* file structure
    * src - includes the matlab files
    * plt - includes the result of analysis 
    * img - includes the dataset , files ending with _rs is original image while its pair ends with _starry
* excution 
    * environment: Matlab R2017
    * files:
        * amptransfer.m: mentioned in Sup-fig-6, applying filter to anoter image
        * filter2d_gen.m and  batch_ftbank.m: preliminary result of using filter bank in decomposing the signal
        * batch_funcfft.m: for fourier analysis mentioned in Method I. a.
        * test_siggraph.m: for result III a, testing S = I*G+(1-G)*(S_k/I_k)
        * test_siggraph2.m: for result III b, testing S = I*G+(1-G)*Vangogh