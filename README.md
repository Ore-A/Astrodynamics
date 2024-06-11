# Astrodynamics
This repository contains MATLAB scripts that perform various calculations related to orbital elements, transformation of position and velocity vectors, and rocket propulsion mission design.

## Contents
1. [OrbitalElements.m](#OrbitalElementsm)
2. [PFtoGQ.m](#PFtoGQm)
3. [RocketPropulsionMission.m](#RocketPropulsionMissionm)

### OrbitalElements.m
This script calculates the orbital elements of a satellite given its position and velocity vectors. The orbital elements calculated include:

- Specific angular momentum
- Node vector
- Eccentricity vector
- Semi-latus parameter
- Semi-major axis
- Time of periapsis passage
- Inclination
- Longitude of ascending node
- Argument of periapsis
- True anomaly

#### Usage
```matlab
OrbitalElements
```

### PQtoGQ.m
This script transforms a position vector from perifocal (PF) coordinates to geocentric equatorial (GQ) coordinates. It takes user inputs for the longitude of the ascending node, the argument of periapsis, the inclination, and the position vector in perifocal coordinates, and outputs the corresponding position vector in geocentric equatorial coordinates.

#### Usage
```matlab
PQtoGQ
```

### RocketPropulsionMission.m
This script designs a two-stage rocket to boost a satellite system into a geostationary transfer orbit (GTO). It calculates various parameters and properties for the rocket stages, including:

- Total mass
- Structure mass
- Propellant mass
- Payload ratio
- Structure ratio
- Velocity change

The script outputs the optimization results and plots the mass change of the rocket as a function of the percentage of velocity change.

#### Usage
```matlab
RocketPropulsionMission
```

## Requirements
- MATLAB (tested with version R2020a and above)

## Author
- Oreoluwa Abejide

