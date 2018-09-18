# Solution for Multilateration Problems with a Bayesian Perspective

This repository holds files and the thesis of Ms. Daniel Jean, which researches on many distribution as likelihood distributions for the Bayesian reasoning. We work with the same prior distribution (Normal) for all cases. The results, implementation, and all related content can be found below.

## Overview of this repository

After reading the thesis, one might be willing to assess the results and/or use them in their own work. Following, we describe the files in this repository so the reader is introduced in how to utilize them.

### solver.m:
File that computes argmax (see thesis) for a given likelihood distribution.

In general, the number of runs is given by k/2, where k is the number of reference points.

In the first run it is generated k reference points, the respective distances are generated following description in the thesis and the initial point. After the first run, the methods for maximizing the cost function receive the same parameters with exception of the starting point, which is generated again to verify if the result of the maximization changes.

* Input:

	* type: Specifies which likelihood function will be used. So far we support:
        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

	* d: Dimension in which the distributions are specified.

	* method: The optimization is done by maximizing the unnormalized posterior function (see thesis). The maximization is done by one of these 3 methods:

		1 - Gradient ascent with exact line search

		2 - Gradient ascent with fixed step size

		3 - Steepest ascent with exact line search.

		Users can specify any of these by the corresponding number.

* Output:
	* argmaxSol: This is a vector containing each best solution for runs with 10, 50 and 100 reference points, respectively placed in the vector in this order.
	Each position of argmaxSol is a data structure containing:
		* err: Norm L2 from the query point q and the optimum point xopt found.
		* q: Is the query point generated (see thesis).
		* xopt: Optimum point found by the optimization method
		* x0: Initial searching point that tries to maximize the cost function.
		* niter: Maximum number of interactions that the optimization algorithm will have to find xopt. It is initially set to 2500.
		* Rn: Set of reference points generated following  a uniform distribution of k points.
		* k: Number of reference points that are generated.
		* r_mean: Mean of the reference points.
		* Sigma: Covariance of the reference points.
		* Dn: Estimated distances following the distribution of the likelihood (see thesis).
		* d: Dimension of each reference point in Rn.
		* type: It is the type of likelihood distribution to be analyzed:

			1 - Rayleigh

			2 - Gamma

			3 - Inverse Gamma

			4 - Exponential

			5 - Nakagami

			6 - Uniform

			Users can specify any of these by the corresponding number.

		* normGrad: The norm L2 of the gradient at the actual x.

		* If the user specifies to plot the graph, the surface is going to be added to the output as well.

* Example of calling solver.m to compute argmax for Rayleigh as the likelihood:

	```
	RayDistro = solver(1, 2, 2);
	```

* For more details see comments on the file.

### Optimization files:
These comments are for the files: GradAscFSZ, GradAscELS and GradAscSELS.

These methods were thought to be stand-alone pieces, so the user might notice some repetition of code in them.

In the beginning, it's generated d-dimensional k reference points and stored at the variable Rn.  After that, constants needed for the process, such as Sigma, r_mean, etc are computed. Continuing, the estimated distances, Dn, are computed following the reasoning presented in the thesis.

All 3 optimization methods share almost the same code described in [Boyd](http://web.stanford.edu/~boyd/cvxbook/), in chapter 9. The differences in each of these files are presented below:

* GradAscFSZ: File that computes the **Gradient Ascent with Fixed Step Size - (GrasAscFSZ)**. Initially the step size is set to 0.1 by the variable *t = 0.1*;

    This method performs fairly well for most of the likelihood distributions.

* GradAscELS: File that computes the **Gradient Ascent with Exact Line Search - (GrasAscELS)**. The *Exact Line Search* refers to the fact that the step size *t* is going to change in each iteration. The computation of the new step size is done by the file *exactLS.m*.

* GradAscSELS: File that computes the **Steepest Ascent with Exact Line Search - (GrasAscSELS)**. The *Steepest* refers to the fact that the step size *t* is going to change in each iteration. The computation of the new step size is done by the file *unnormSteepAsc.m*. This method used L1 norm.

Aside from the differences described above, all optimization methods share the same structure for input and outputs, as follows:

* Input:
    * type: Specifies which likelihood function will be used. So far we support:

        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

    * plotGraf: Binary entry which specifies if users want to save surface and meshgrid for plotting the graph.

        * 0: Means that users don't want to plot any graph afterwards.

        * 1: Means that users want to plot graphs. Users can plot graphs using:
        ```
		plotInfoOnFig(Distro, Distro.likelihoodSurface);
		```

        More information on how to plot the resulting graphs are provided in the *plotInfoOnFig.m* file.

    * k: Number of reference points that are generated.
    * d: Dimension of each reference point in Rn.
    * Rn: Set of reference points generated following  a uniform distribution of k points.
    * Dn: Estimated distances following the distribution of the likelihood (see thesis).
    * q: Is the target query point generated (see thesis).

* Output:
    * err: Norm L2 from the query point q and the optimum point xopt found.
    * q: Is the query point generated (see thesis).
    * xopt: Optimum point found by the optimization method
    * x0: Initial searching point that tries to maximize the cost function.
    * niter: Maximum number of interactions that the optimization algorithm will have to find xopt. It is initially set to 2500.
    * Rn: Set of reference points generated following  a uniform distribution of k points.
    * k: Number of reference points that are generated.
    * r_mean: Mean of the reference points.
    * Sigma: Covariance of the reference points.
    * Dn: Estimated distances following the distribution of the likelihood (see thesis).
    * d: Dimension of each reference point in Rn.
    * type: It is the type of likelihood distribution to be analyzed:

        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

    * normGrad: The norm L2 of the gradient at the actual x.
    * If the user specifies to plot the graph, the surface is going to be added to the output as well.

* Example of calling the optimization files:

	```
	Distro = GradAscFSZ(1, 2, 2); % Using Rayleigh as likelihood function
	```

    ```
	Distro = GradAscELS(2, 2, 2); % Using Gamma as likelihood function
	```

    ```
	Distro = GradAscSELS(3, 2, 2); % Using Inverse Gamma as likelihood function
	```

* For more details see comments on files.

### Auxiliary files for optimization algorithms
The two auxiliary files for *GradAscELS.m* and *GradAscSELS* are, respectively: *exactLS.m* and *unnormSteepDesc.m*.

The output of each method is the new *t* based on the actual x and gradient of f(x), g(x).

The input for exactLS is:

* type: Specifies which likelihood function will be used. So far we support:
    1 - Rayleigh

    2 - Gamma

    3 - Inverse Gamma

    4 - Exponential

    5 - Nakagami

    6 - Uniform

    Users can specify any of these by the corresponding number.

* x: Actual point where f(x) and g(x) will be computed.
* d: Dimension in which the distributions are specified.
* Dx: Derivative of f(x) at point x.
* Rn: Set of reference points generated following  a uniform distribution of k points.
* Dn: Estimated distances following the distribution of the likelihood (see thesis).
* Sigma: Covariance of the reference points.
* r_mean: Mean of the reference points.

The input for unnormSteepDesc is:

* type: Specifies which likelihood function will be used. So far we support:

    1 - Rayleigh

    2 - Gamma

    3 - Inverse Gamma

    4 - Exponential

    5 - Nakagami

    6 - Uniform

    Users can specify any of these by the corresponding number.

* g: Derivative of f(x) at point x.
* x: Actual point where f(x) and g(x) will be computed.

An example on how to utilize these methods can be found in the optimization algorithm described above.

### compCostFn:
This file contains the callers for each cost function supported so far.
The input and output are described below:

* Input:
    * type: Specifies which likelihood function will be used. So far we support:
        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

    * Rn: Set of reference points generated following  a uniform distribution of k points.
    * d: Dimension in which the distributions are specified.
    * x: Actual point where the cost function will be computed.
    * Dn: Estimated distances following the distribution of the likelihood (see thesis).
    * r_mean: Mean of the reference points.
    * Sigma: Covariance of the reference points.

* Output:
    The output is an array containing, respectively:

    * Unnormalized posterior at point x.
    * Prior at point x.
    * Likelihood at point x.

    The array is store in the variable *fx*.

* Example:

        x = [-1, 1];
        Distro = GradDescSELS(4, 1, 10, 2); % First compute the distribution.
        costFnVal = compCostFn(Distro.type, Distro.Rn, Distro.d, x, Distro.Dn, Distro.r_mean, Distro.Sigma);

        % Users can access the values by:
        costFnVal(1) % Unnormalized posterior
        costFnVal(2) % prior
        costFnVal(3) % likelihood

At some point, a task from this repository, will use this function.

### gdFunction:
This file computes the first derivative of the unnormalized posterior (prior x likelihood), also known as the gradient.

The input and output parameters are described below:

* Input:
    * Rn: Set of reference points generated following  a uniform distribution of k points.
    * x: Is the actual point x to be computed the gradient.
    * Dn: Estimated distances following the distribution of the likelihood (see thesis).
    * r_mean: Mean of the reference points.
    * Sigma: Covariance of the reference points.
    * type: Specifies which likelihood function will be used. So far we support:
        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

* Output
    The output is the value of g(x) - gradient - at point x. This value is stored in the variable *result*.

* Example to compute g(x) for Uniform distribution as the likelihood:

        % Variables Rn, Dn, r_mean and Sigma are should be generated before
        x = [-.5, .5];
        g = gdFunction(Rn, x, Dn, r_mean, Sigma, type);

        %Visualize g:
        g


###CompEvidence
Since this thesis is concerned with the posterior distribution, we need to have the Evidence of the distribution (see thesis). In order to approximate the evidence one might want to use this file.

* Input:
    * type: Specifies which likelihood function will be used. So far we support:

        1 - Rayleigh

        2 - Gamma

        3 - Inverse Gamma

        4 - Exponential

        5 - Nakagami

        6 - Uniform

        Users can specify any of these by the corresponding number.

    * Distro: Resulting data structure from any of the optimization methods.
    * nSamples: Number of samples to generate a good approximation for the evidence.
    * plotIt: Binary option to plot the final result of the normalized posterior.

* Output:
    * Distro: The new data structure containing the old data structure (the input Distro) and the new field *EvidenceAppx*, which is the approximation of the evidence for the unnormalized posterior.

    In case the user chooses to plot the graph, the information of the plot will also be stored in the new Distro.

* Example of computing the normalized posterior for Gamma as the likelihood function:

        Distro = GradDescSELS(2, 1, 10, 2); % First compute the distribution.
        NewDistro = CompEvidence(Distro.type, Distro, 100, 1);

    This example should plot the graph of the normalized posterior for Gamma distribution as the likelihood function.

###plotCostFunction
This routine computes all necessary variables to plot graphs of this research. This file does not plot the graph itself, for that, use *plotInfoOnFig.m* file.

* Input:
    * type: Specifies which likelihood function will be used. So far we support:

    1 - Rayleigh

    2 - Gamma

    3 - Inverse Gamma

    4 - Exponential

    5 - Nakagami

    6 - Uniform

    Users can specify any of these by the corresponding number.

    * Rn: Set of reference points generated following  a uniform distribution of k points.
    * d: Dimension in which the distributions are specified.
    * Dn: Estimated distances following the distribution of the likelihood (see thesis).
    * r_mean: Mean of the reference points.
    * Sigma: Covariance of the reference points.

* Output:
    New data structure *Distro* containing the variables to use the file *plotInfoOnFig.m*.

    Generally speaking, this routine is called by one of the optimization methods.


###plotInfoOnFig
This file plots graphs in the format we are adopting in this thesis.
* Input:
    * Distro: Resulting data structure from any of the optimization methods.
    * plotPart: In the Distro data structure there are 3 fields that can potentially use this routine:

    1 - posteriorSurface
    2 - priorSurface
    3 - likelihoodSurface

    Upon using *plotInfoOnFig.m*, the user should choose which surface to plot.

* Output:
    surfacePlotted: The output of the surfc is stored in this variable.

* Example of use:

        % First compute the distribution.
        Distro = GradDescSELS(3, 1, 10, 2);

        %Plot the graph:
        surfacePlotted =  plotInfoOnFig(Distro, Distro.posteriorSurface);

    This specific example should plot the graph of the unnormalized posterior for Inverse Gamma distribution as the likelihood function.

## Built With

* Matlab

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
