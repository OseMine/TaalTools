# Adding New Filter Types to TT_Analog_Filters

## Step 1: Add Filter Type to Slider
1. Increment the max value in slider2
2. Add your filter name to the slider options list
```jesusonic
slider2:0<0,8,1{Prophet-5 Rev3,Oberheim OB-X,Oberheim SEM,Korg MS-20,Moog,Moog 4-Pole,Apple 12-Pole,Apple 2-Pole,YOUR_FILTER}>Filter Type
```

## Step 2: Add Filter States
Add state variables in @init section:
```jesusonic
// Add your filter states
your_filter_x1l = your_filter_x2l = your_filter_y1l = your_filter_y2l = 0;
your_filter_x1r = your_filter_x2r = your_filter_y1r = your_filter_y2r = 0;
```

## Step 3: Implement Filter Processing
Add new case in the filter type selection chain:
```jesusonic
) : filtertype == 8 ? ( // Your Filter
  // Calculate basic coefficients
  sx = 16 + freq * 1.20103 / 200;
  cx = floor(exp(sx*log(1.059))*8.17742);
  cutoff = 2 * cx / srate;
  
  // Scale resonance 0-0.85 to your range
  res_scaled = slider5 * your_scale;
  
  // Calculate filter-specific coefficients
  k = your_resonance_calculation(cutoff, res_scaled);
  c1 = your_coefficient_calculation1(k);
  c2 = your_coefficient_calculation2(c1);

  // Different modes (LP/HP/BP)
  filtermode == 0 ? ( // LP
    c3 = your_lp_calculation(c1, c2);
    a0 = 2 * c3;
    a1 = 4 * c3;
    a2 = 2 * c3;
  ) : filtermode == 1 ? ( // HP
    c3 = your_hp_calculation(c1, c2); 
    a0 = 2 * c3;
    a1 = -4 * c3;
    a2 = 2 * c3;
  ) : ( // BP
    c3 = your_bp_calculation(c1, c2);
    a0 = 2 * c3 * cutoff;
    a1 = 0;
    a2 = -a0;
  );
  
  b1 = your_feedback1_calculation(c2);
  b2 = your_feedback2_calculation(c1);

  // Process left channel
  outputl = a0*input0 + a1*your_filter_x1l + a2*your_filter_x2l 
            - b1*your_filter_y1l - b2*your_filter_y2l;
  your_filter_x2l = your_filter_x1l;
  your_filter_x1l = input0;
  your_filter_y2l = your_filter_y1l;
  your_filter_y1l = outputl;
  spl0 = outputl * outgain;

  // Process right channel if stereo
  mono == 0 ? (
    outputr = a0*input1 + a1*your_filter_x1r + a2*your_filter_x2r 
              - b1*your_filter_y1r - b2*your_filter_y2r;
    your_filter_x2r = your_filter_x1r;
    your_filter_x1r = input1;
    your_filter_y2r = your_filter_y1r;
    your_filter_y1r = outputr;
    spl1 = outputr * outgain;
  ) : spl1 = spl0;
```

## Step 4: Update Display
Add your filter name to the @gfx section:
```jesusonic
gfx_drawstr(filtertype == 0 ? "Prophet-5 Rev3" : 
            // ...existing filters...
            filtertype == 7 ? "Apple 2-Pole" : "Your Filter");
```

## Tips
- Study existing filter implementations for coefficient calculations
- Test filter stability across frequency range
- Verify proper resonance scaling
- Check all filter modes (LP/HP/BP) behavior
- Test both mono and stereo operation

## Common Pitfalls
1. Coefficient instability at high frequencies
2. Resonance scaling issues
3. Poor performance at filter mode transitions
4. DC offset in output
5. Numerical instability

## Example Filter Types to Study
- Apple 2-Pole: Simple but effective implementation
- Moog 4-Pole: Complex resonance handling
- Prophet-5: Classic analog modeling
