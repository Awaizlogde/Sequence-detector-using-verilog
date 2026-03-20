# RTL Design Files

This directory contains the RTL implementations of the sequence detector.

Two different design approaches are implemented:

1. **FSM-Based Sequence Detector**
2. **Parameterized Shift Register Based Sequence Detector**

---

## FSM-Based Sequence Detector

This implementation detects the sequence using a **Finite State Machine (FSM)**.

The FSM transitions through a series of states that represent partial matches of the input sequence.

Example state progression for detecting `1011`:

S0 → S1 → S2 → S3 → S4

Where:
- **S0** : Initial state
- **S1** : Detected `1`
- **S2** : Detected `10`
- **S3** : Detected `101`
- **S4** : Sequence detected

This approach is straightforward but **sequence-specific**, meaning the state machine must be redesigned if the target sequence changes.

---

## Parameterized Sequence Detector

This implementation uses a **shift register based sliding window technique**.

Incoming bits are shifted into an N-bit register, and the contents of the register are compared with a parameterized sequence.

Example parameters:

verilog

*parameter N = 4;*

*parameter [N-1:0] SEQ = 4'b1011;*

### Advantages of this approach:

Reusable RTL

Sequence can be modified through parameters

Simpler hardware implementation

Scalable to different sequence lengths


### Both designs are verified using the same testbench located in the tb directory.
