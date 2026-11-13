# Spring-Mass-Damper (SMD) System Simulation in Simulink

A Simulink model of a second-order mechanical **spring-mass-damper** system, built from basic blocks (gain, sum, integrators) and driven by a unit step force.

![Simulink model](images/smd_model.jpeg)

## Governing equation

m·x'' + c·x' + k·x = F(t)

Rearranged for block-diagram implementation:

x'' = (1/m)(F − c·x' − k·x)

## Parameters

| Symbol | Meaning | Value | Block |
|---|---|---|---|
| m | Mass | 2 kg | Gain `1/2` |
| c | Damping coefficient | 3 N·s/m | Gain `3` (velocity feedback) |
| k | Spring stiffness | 3 N/m | Gain `3` (position feedback) |
| F | Input force | 1 N (unit step) | Step block |

## Model structure

Step → Sum (+ − −) → Gain 1/2 → Integrator (velocity) → Integrator (position) → Scope

- Velocity is fed back through gain `c` into the sum block.
- Position is fed back through gain `k` into the sum block.

## Transfer function

X(s)/F(s) = 1 / (2s² + 3s + 3)

## Analytical results

| Quantity | Value |
|---|---|
| Natural frequency ωn | √(k/m) ≈ 1.225 rad/s |
| Damping ratio ζ | c / (2√(km)) ≈ 0.612 (underdamped) |
| Damped frequency ωd | ≈ 0.968 rad/s |
| Poles | −0.75 ± j0.968 |
| Steady-state value | F/k = 0.333 |
| Percent overshoot | ≈ 9.5 % (peak ≈ 0.365) |
| Peak time | ≈ 3.2 s |
| Settling time (2 %) | ≈ 5.3 s |

## Expected scope output

A smooth underdamped step response: starts at 0 with zero slope, overshoots to about 0.365 near t ≈ 3.2 s, then settles at 0.333 within about 6 s.

![Scope output](images/scope_output.jpeg)

## How to run

1. Open MATLAB (R2018b or newer recommended) with Simulink installed.
2. Open `smd.slx`.
3. Set the simulation stop time to `10`.
4. Click **Run** and double-click the Scope block.
5. (Optional) Run `smd_analysis.m` to verify the result with the Control System Toolbox.

## Repository contents

```
smd-simulink/
├── smd.slx              % Simulink model
├── smd_analysis.m       % Analytical check using transfer function
├── images/
│   ├── smd_model.png    % Block diagram screenshot
│   └── scope_output.png % Scope result screenshot
├── .gitignore
└── README.md
```

## Possible extensions

- Vary the damping coefficient to compare underdamped, critically damped, and overdamped responses.
- Replace the step with a sine or pulse input.
- Add a PID controller to regulate position.

## License

MIT
