model Farma
  connector konektor
    Real conc(unit = "mg/l");
    flow Real q(unit = "mg/h");
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-26.96, 24.57}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-72.52, 76.3}, {126.52, -124.3}})}));
  end konektor;

  model absorbce
    Real koncentrace;
    parameter Real F;
    Farma.konektor konektor1 annotation(Placement(visible = true, transformation(origin = {60, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {60, -40}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-40, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    der(koncentrace) = u + konektor1.q;
    -konektor1.q = koncentrace * F;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {7.95, -3}, fillColor = {85, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-50.35, 56.71}, {50.35, -56.71}}, endAngle = 360)}));
  end absorbce;

  model kompartment
    parameter Real C0;
    //Pocatecni koncentrace
    parameter Real Vd;
    Real C(start = C0 / Vd);
    Farma.konektor konektor1 annotation(Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-20, -20}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    der(C) = konektor1.q;
    konektor1.conc = C / Vd;
    //- konektor2.q;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {11.94, -5.15}, fillColor = {170, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-51.76, 59.95}, {51.76, -59.95}})}));
  end kompartment;

  model eliminace_nulteho_radu
    parameter Real CL;
    Farma.konektor konektor1 annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-25, 5}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    konektor1.q = CL;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {0, 18.74}, points = {{-22.0126, 28.5714}, {8.90072, 28.5714}, {32.3199, 8.8993}, {34.1935, -15.9251}, {16.8632, -37.4707}, {-11.2398, -37.4707}, {-33.2539, -20.6089}, {-33.2539, 6.08899}, {-20.1391, 29.0398}, {-21.0759, 31.8501}, {-20.1391, 29.9766}, {-16.392, 29.9766}, {-20.1391, 32.3185}}, color = {170, 0, 255}), Text(origin = {-2, -62}, extent = {{-68, 20}, {68, -20}}, textString = "%name")}));
  end eliminace_nulteho_radu;

  model eliminace_prvniho_radu
    parameter Real CL;
    Farma.konektor konektor1 annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-25, 5}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    konektor1.q = konektor1.conc * CL;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {0, 18.74}, points = {{-22.0126, 28.5714}, {8.90072, 28.5714}, {32.3199, 8.8993}, {34.1935, -15.9251}, {16.8632, -37.4707}, {-11.2398, -37.4707}, {-33.2539, -20.6089}, {-33.2539, 6.08899}, {-20.1391, 29.0398}, {-21.0759, 31.8501}, {-20.1391, 29.9766}, {-16.392, 29.9766}, {-20.1391, 32.3185}}, color = {170, 0, 255}), Text(origin = {-3, -62}, extent = {{-75, 26}, {75, -26}}, textString = "%name")}));
  end eliminace_prvniho_radu;

  model Jedno_kompartmentovy_model
    Farma.absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-65, -65}, {65, 65}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = 4) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Farma.eliminace_nulteho_radu eliminace_nulteho_radu1(CL = 1) annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
    Farma.kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  equation
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-1, -86}, {13.6709, -86}, {13.6709, 10.1266}, {35.443, 13}, {33, 13}}));
    connect(eliminace_nulteho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{48.75, -57.75}, {20.2532, -57.75}, {20.2532, 9.62025}, {34.9367, 13}, {33, 13}}));
    connect(absorbce1.u, pulse1.y) annotation(Line(points = {{-53, -34}, {-74.9367, -34}, {-74.9367, -17.2152}, {-53.6709, -17.2152}, {-53.6709, 0}, {-68.3544, 0}, {-68.3544, 0}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Jedno_kompartmentovy_model;

  model Dvou_kompartmentovy_model
    Farma.absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-45, 25}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
    Farma.kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {40, 60}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Farma.kompartment kompartment2(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {47.5, -7.5}, extent = {{-27.5, -27.5}, {27.5, 27.5}}, rotation = 0)));
    Farma.eliminace_nulteho_radu eliminace_nulteho_radu1(CL = 1) annotation(Placement(visible = true, transformation(origin = {75, -75}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = 4) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulse1.y, absorbce1.u) annotation(Line(points = {{-69, 80}, {-54.6835, 80}, {-54.6835, 44.0506}, {-54.6835, 44.0506}}, color = {0, 0, 127}));
    connect(kompartment2.konektor1, eliminace_nulteho_radu1.konektor1) annotation(Line(points = {{64, -13}, {73.4177, -13}, {73.4177, -47.5949}, {46.5823, -47.5949}, {46.5823, -72.9114}, {68.3544, -72.9114}, {68.3544, -72.9114}}));
    connect(kompartment1.konektor1, kompartment2.konektor1) annotation(Line(points = {{55, 55}, {73.9241, 55}, {73.9241, 9.11392}, {21.2658, 9.11392}, {21.2658, -11.1392}, {41.0127, -11.1392}, {41.0127, -11.1392}}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-18, 7}, {12.1519, 7}, {12.1519, 55.1899}, {34.9367, 55.1899}, {34.9367, 55.1899}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Dvou_kompartmentovy_model;

  model Jedno_kompartmentovy_model_1r
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = 4) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Farma.kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
    Farma.absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-42, -60}, extent = {{-65, -65}, {65, 65}}, rotation = 0)));
    Farma.eliminace_prvniho_radu eliminace_prvniho_radu1(CL = 1) annotation(Placement(visible = true, transformation(origin = {60, -62}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  equation
    connect(eliminace_prvniho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{50, -60}, {35.9494, -60}, {35.9494, 8}, {33, 8}, {33, 13}}));
    connect(absorbce1.u, pulse1.y) annotation(Line(points = {{-55, -34}, {-74.9367, -34}, {-74.9367, -17.2152}, {-53.6709, -17.2152}, {-53.6709, 0}, {-68.3544, 0}}, color = {0, 0, 127}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-3, -86}, {13.6709, -86}, {13.6709, 13}, {33, 13}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Jedno_kompartmentovy_model_1r;

  model Davkovac
    parameter Real Cmin;
    parameter Real Cmax;
    Boolean x;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {99, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {80, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  initial equation
    x = true;
  equation
    when u < Cmin then
      x = true;
    elsewhen u > Cmax then
      x = false;
    end when;
    if x then
      y = 4;
    else
      y = 0;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-3, -3}, fillColor = {187, 206, 12}, fillPattern = FillPattern.Solid, extent = {{-41, 41}, {41, -41}}, endAngle = 360)}));
  end Davkovac;

  model senzor
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {95, 1}, extent = {{-31, -31}, {31, 31}}, rotation = 0), iconTransformation(origin = {73, 1}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
    konektor konektor1 annotation(Placement(visible = true, transformation(origin = {-90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-86, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  equation
    y = konektor1.conc;
    konektor1.q = 0;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-14, -8}, fillColor = {85, 0, 0}, fillPattern = FillPattern.Forward, extent = {{-50, 80}, {50, -80}}, endAngle = 360)}));
  end senzor;

  model Davkovani_diskretne
    Davkovac davkovac1(Cmin = 1, Cmax = 2) annotation(Placement(visible = true, transformation(origin = {-52, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-30, -48}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
    senzor senzor1 annotation(Placement(visible = true, transformation(origin = {-80, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    eliminace_nulteho_radu eliminace_nulteho_radu1(CL = 1) annotation(Placement(visible = true, transformation(origin = {76, -36}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {29, 35}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  equation
    connect(senzor1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-80, 31}, {-80, 31}, {-80, 40}, {2, 40}, {2, 30}, {22, 30}, {22, 30}}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-17, -57}, {0, -57}, {0, 31}, {25, 31}}));
    connect(eliminace_nulteho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{68.5, -34.5}, {2, -34.5}, {2, 30}, {24, 30}, {24, 30}, {24, 30}}));
    connect(senzor1.y, davkovac1.u) annotation(Line(points = {{-80, 15}, {-65.5, 15}, {-65.5, 14}, {-60, 14}}, color = {0, 0, 127}));
    connect(davkovac1.y, absorbce1.u) annotation(Line(points = {{-44, 14}, {-34, 14}, {-34, -22}, {-60, -22}, {-60, -40}, {-34, -40}, {-34, -40}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_diskretne;

  model Regulator
    parameter Real Cmin;
    parameter Real Cmax;
    parameter Real p;
    Real Cavg;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-99, 1}, extent = {{-29, -29}, {29, 29}}, rotation = 0), iconTransformation(origin = {-74, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {101, -1}, extent = {{-27, -27}, {27, 27}}, rotation = 0), iconTransformation(origin = {82, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  equation
    Cavg = (Cmax + Cmin) / 2 - u;
    if y < 0 then
      y = 0;
    else
      y = Cavg + ((Cmax + Cmin) / 2 - u) * p;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-2, -2}, extent = {{-66, 66}, {66, -66}}), Text(origin = {-3, 0}, extent = {{-39, 18}, {39, -18}}, textString = "%name")}));
  end Regulator;

  model Davkovani_spojite
    Regulator regulator1(Cmin = 2, Cmax = 3) annotation(Placement(visible = true, transformation(origin = {-32, 24}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-37, -37}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {35, 29}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    eliminace_nulteho_radu eliminace_nulteho_radu1 annotation(Placement(visible = true, transformation(origin = {67, -35}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    senzor senzor1 annotation(Placement(visible = true, transformation(origin = {-77, 23}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  equation
    connect(senzor1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-88, 23}, {-88, 23}, {-88, 52}, {22, 52}, {22, 26}, {32, 26}, {32, 26}}));
    connect(eliminace_nulteho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{61, -34}, {22, -34}, {22, 26}, {30, 26}, {30, 26}}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-23, -46}, {14, -46}, {14, 26}, {32, 26}, {32, 26}, {32, 26}}));
    connect(regulator1.y, absorbce1.u) annotation(Line(points = {{-11, 24}, {-2, 24}, {-2, -10}, {-56, -10}, {-56, -28}, {-42, -28}, {-42, -28}}, color = {0, 0, 127}));
    connect(senzor1.y, regulator1.u) annotation(Line(points = {{-68, 23}, {-52, 23}, {-52, 22}, {-52, 22}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_spojite;

  model Denni_Davkovac
    parameter Real doseLen = 1 / 60;
    parameter Real dpd = 1;
    parameter Real dose = 1 / 6;
    discrete Real pulseTime;
    Real prePt;
    Real doseFlow;
    Real doseInterval;
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {-68, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {79, -77}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  initial equation
    24 / dpd = doseInterval;
    pulseTime = time + doseInterval;
  equation
    when time > pre(pulseTime) + doseLen then
      prePt = pre(pulseTime);
      pulseTime = time + doseInterval;
    end when;
    24 / dpd = doseInterval;
    dose = doseLen * doseFlow;
    if pulseTime < time and pulseTime + doseLen > time then
      y = doseFlow;
    else
      y = 0;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Rectangle(origin = {-20, 1}, extent = {{-72, 93}, {72, -93}}), Text(origin = {-33, 14}, extent = {{-45, 66}, {45, -66}}, textString = "%name")}));
  end Denni_Davkovac;

  model Davkovani_pravidelne_denne
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-24, 16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {53, 13}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    eliminace_prvniho_radu eliminace_prvniho_radu1 annotation(Placement(visible = true, transformation(origin = {58, -32}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    Denni_Davkovac denni_Davkovac1(dpd = 1) annotation(Placement(visible = true, transformation(origin = {-66, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(kompartment1.konektor1, eliminace_prvniho_radu1.konektor1) annotation(Line(points = {{50, 10}, {30, 10}, {30, -30}, {52, -30}, {52, -30}}));
    connect(denni_Davkovac1.y, absorbce1.u) annotation(Line(points = {{-58, 20}, {-28, 20}, {-28, 22}, {-28, 22}}, color = {0, 0, 127}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-14, 10}, {50, 10}, {50, 8}, {50, 8}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_pravidelne_denne;

  model Davkovani_pravidelne_po6hod
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-24, 16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {45, 13}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    eliminace_prvniho_radu eliminace_prvniho_radu1 annotation(Placement(visible = true, transformation(origin = {51, -37}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    Denni_Davkovac denni_Davkovac1(dpd = 6) annotation(Placement(visible = true, transformation(origin = {-72, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(kompartment1.konektor1, eliminace_prvniho_radu1.konektor1) annotation(Line(points = {{42, 10}, {22, 10}, {22, -38}, {44, -38}, {44, -38}}));
    connect(denni_Davkovac1.y, absorbce1.u) annotation(Line(points = {{-64, 20}, {-28, 20}, {-28, 22}, {-28, 22}}, color = {0, 0, 127}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-14, 10}, {42, 10}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_pravidelne_po6hod;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Farma;