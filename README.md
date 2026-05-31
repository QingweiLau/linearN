# linearN

`linearN` is a MATLAB implementation of a general linear single-track model for articulated vehicles with an arbitrary number of vehicle units and axles.

The main function, `articABCD`, builds a continuous-time state-space model for an articulated vehicle at a constant longitudinal speed. The model is intended for lateral dynamics analysis, controller design, eigenvalue analysis, and step-response simulation of multi-unit road vehicles such as tractor-semitrailers, longer combination vehicles, and other articulated vehicle configurations.

## Features

* Builds a linear state-space model for an articulated vehicle with `n` units and `N` axles.
* Supports different numbers of axles on different vehicle units.
* Uses vehicle mass, yaw inertia, axle locations, cornering stiffness, joint locations, and vehicle speed as inputs.
* Returns continuous-time state-space matrices:

```matlab
[Am, Bm, Cm, Dm] = articABCD(M, J, L, Ca, Xf, Xr, U);
```

* Includes an example parameter file for a three-unit Nordic combination vehicle.


## Model description

The model represents the lateral dynamics of an articulated vehicle using a linear single-track formulation.

For an articulated vehicle with `n` vehicle units and `N` axles, the reduced independent state vector has `2n` states:

```text
x = [beta_1, r_1, r_2, ..., r_n, theta_1, theta_2, ..., theta_(n-1)]'
```

where:

* `beta_1` is the body slip angle of the first unit.
* `r_i` is the yaw rate of vehicle unit `i`.
* `theta_i` is the articulation angle between unit `i` and unit `i+1`.

The inputs are the steering angles at each axle:

```text
u = [delta_1, delta_2, ..., delta_N]'
```

The function returns:

* `Am`: state matrix
* `Bm`: input matrix
* `Cm`: output matrix
* `Dm`: feedthrough matrix

The output is currently defined as all independent states.

## Requirements

This project requires MATLAB.

For basic matrix generation with `articABCD.m`, no special toolbox is required.
For state-space simulation using commands such as `ss` and `step`, MATLAB Control System Toolbox is required.

## Quick start

Clone the repository:

```bash
git clone https://github.com/QingweiLau/linearN.git
cd linearN
```

Open MATLAB and add the repository folder to the MATLAB path:

```matlab
addpath(pwd)
```

Load the example Nordic vehicle parameters:

```matlab
Nordic01_par
```

Set the vehicle speed:

```matlab
kph = 1/3.6;
U = 80 * kph;
```

Build the state-space model:

```matlab
[Am, Bm, Cm, Dm] = articABCD(M, J, L, Ca, Xf, Xr, U);
```

Create a state-space system using front-axle steering as the input:

```matlab
sys = ss(Am, Bm(:,1), Cm, Dm(:,1));
```

Simulate and plot the step response:

```matlab
[y, t] = step(sys, 5);

figure
plot(t, y(:,2:4))
xlabel('Time (s)')
ylabel('Yaw rate (rad/s)')
legend('Unit 1', 'Unit 2', 'Unit 3')
grid on
```

## Input format

### `M`

Masses of the vehicle units.

```matlab
M = [M1, M2, ..., Mn];
```

Unit: kg

Example:

```matlab
M = [23, 3, 34] * 1000;
```

### `J`

Yaw moments of inertia of the vehicle units.

```matlab
J = [J1, J2, ..., Jn];
```

Unit: kg m²

Example:

```matlab
J = [15, 3, 46] * 1000;
```

### `L`

Cell array of axle longitudinal positions relative to the center of gravity of each vehicle unit.

```matlab
L = {L1, L2, ..., Ln};
```

Each `Li` is a vector containing the axle positions of unit `i`.

Unit: m

Example:

```matlab
L1 = [3.88, -1.02, -2.39];
L2 = [0.65, -0.65];
L3 = [-1.33, -2.64, -3.95];
L = {L1, L2, L3};
```

### `Ca`

Cell array of axle cornering stiffness values.

```matlab
Ca = {Ca1, Ca2, ..., Can};
```

The structure of `Ca` should match the structure of `L`.

Unit: N/rad

Example:

```matlab
Ca1 = [356, 480, 480] * 1000;
Ca2 = [402, 402] * 1000;
Ca3 = [432, 432, 432] * 1000;
Ca = {Ca1, Ca2, Ca3};
```

### `Xf`

Front joint positions relative to the center of gravity of each vehicle unit.

```matlab
Xf = [Xf1, Xf2, ..., Xfn];
```

Unit: m

For the first unit, the front joint value is not used by the model.

### `Xr`

Rear joint positions relative to the center of gravity of each vehicle unit.

```matlab
Xr = [Xr1, Xr2, ..., Xrn];
```

Unit: m

### `U`

Constant longitudinal vehicle speed.

Unit: m/s

Example:

```matlab
U = 80 / 3.6;
```

## Example vehicle

The file `Nordic01_par.m` provides parameters for a three-unit Nordic combination vehicle. The data are based on the example referenced in:

Kharrazi, S., Gordon, T., & Lidberg, M. “Improving lateral performance of longer combination vehicles—An approach based on eigenstructure assignment.” IEEE Intelligent Vehicles Symposium, 2012.

## Notes

* The model assumes constant longitudinal speed.
* Tire lateral forces are represented using linear cornering stiffness.
* The function eliminates dependent constraints and returns a reduced state-space model using independent states.
* Steering inputs are defined at axle level, so the number of inputs equals the total number of axles.

## Citation

If you use this code in academic work, please cite the repository and the relevant vehicle dynamics references used in your study.

Suggested repository citation:

```text
Liu, Q. linearN: MATLAB linear single-track model for articulated vehicles. GitHub repository: https://github.com/QingweiLau/linearN
```
