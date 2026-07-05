ELEC9123 Design Task B (Wireless Communications)
Performance Analysis Verification via Monte Carlo Simulations

Student Name: Mingze Lyu    z5622382

----------------------------------

## PROJECT STRUCTURE

ELEC9123_TaskB_Level5

│
├── main.m
├── parameters.m
│
├── Verify
│   ├── laplace_verify.m
│   └── plot_noise.m
│
├── BER
│   ├── ber_awgn.m
│   ├── ber_laplace.m
│   ├── ber_rayleigh.m
│   ├── ber_random_rayleigh.m
│   ├── ber_rician.m
│   ├── ber_random_rician.m
│   └── plot_ber.m
│
└── Outage
    ├── outage_rayleigh.m
    ├── outage_random_rayleigh.m
    ├── outage_rician.m
    ├── outage_random_rician.m
    └── plot_outage.m

------------------------------------

## HOW TO RUN THE PROJECT

1. Open MATLAB.

2. Set the current working directory to:

       ELEC9123_TaskB_Level5

3. Run:

       main

4. The program will automatically:

   • Load the simulation parameters.

   • Verify the generated Laplacian random variables.

   • Simulate BER performance under different channel models.

   • Simulate Outage Probability under different channel models.

   • Plot all theoretical and simulation results.

--------------------------------------

## FILE DESCRIPTION

main.m

Master script that runs all simulations and generates the figures.

--------------------------------------

Verify

laplace_verify.m

Generates Laplacian random variables using the inverse transform sampling method.

plot_noise.m

Plots the simulated and theoretical PDF and CDF of the Laplacian noise.

--------------------------------------

BER

ber_awgn.m
Computes the BER over the AWGN channel.

ber_laplace.m
Computes the BER over the Laplacian noise channel.

ber_rayleigh.m
Computes the BER over the Rayleigh fading channel.

ber_random_rayleigh.m
Computes the BER for randomly deployed users over Rayleigh fading channels.

ber_rician.m
Computes the BER over the Rician fading channel.

ber_random_rician.m
Computes the BER for randomly deployed users over Rician fading channels.

plot_ber.m
Plots the theoretical and simulated BER curves.

--------------------------------------

Outage

outage_rayleigh.m
Computes the outage probability over the Rayleigh fading channel.

outage_random_rayleigh.m
Computes the outage probability for randomly deployed users over Rayleigh fading channels.

outage_rician.m
Computes the outage probability over the Rician fading channel.

outage_random_rician.m
Computes the outage probability for randomly deployed users over Rician fading channels.

plot_outage.m
Plots the theoretical and simulated outage probability curves.

--------------------------------------

## SIMULATION SETTINGS

Modulation:
BPSK

Channel Models:
• AWGN

• Laplacian Noise

• Rayleigh Fading

• Random User Rayleigh Fading

• Rician Fading

• Random User Rician Fading

Random User Distribution:
Uniform distribution inside a circular cell

Performance Metrics:
• Bit Error Rate (BER)

• Outage Probability

--------------------------------------

## END OF README