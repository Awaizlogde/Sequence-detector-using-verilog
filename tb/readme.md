
# Testbench

This directory contains the testbench used to verify the sequence detector RTL designs.


## Testbench Description

The testbench generates:

- Clock signal (`clk
  
- Reset signal (`rst`)
  
- Serial input stream (`data_in`)
  

The input stream is applied to the **Device Under Test (DUT)** to verify correct sequence detection.

Observed signals during simulation include:

- `clk`
  
- `data_in`
  
- `shift_reg`
  
- `detected`

Waveforms are used to confirm that the detector correctly asserts the output when the target sequence appears in the input stream.

---

## Testbench Usage

Currently, **the same testbench is used for both RTL implementations**:

- FSM-based sequence detector
- Parameterized sequence detector

The only change required is the **DUT module instantiation**.

For example:

### FSM Design

```verilog
seq_detector_fsm DUT (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .detected(detected)
);
```

### Parameterized deign
```verilog
seq_detector DUT (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .detected(detected)
);
```
