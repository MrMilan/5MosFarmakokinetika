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
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {0, 18.74}, points = {{-22.0126, 28.5714}, {8.90072, 28.5714}, {32.3199, 8.8993}, {34.1935, -15.9251}, {16.8632, -37.4707}, {-11.2398, -37.4707}, {-33.2539, -20.6089}, {-33.2539, 6.08899}, {-20.1391, 29.0398}, {-21.0759, 31.8501}, {-20.1391, 29.9766}, {-16.392, 29.9766}, {-20.1391, 32.3185}}, color = {170, 0, 255})}));
  end eliminace_nulteho_radu;

  model eliminace_prvniho_radu
    parameter Real CL;
    Farma.konektor konektor1 annotation(Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-25, 5}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    konektor1.q = konektor1.conc * CL;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Line(origin = {0, 18.74}, points = {{-22.0126, 28.5714}, {8.90072, 28.5714}, {32.3199, 8.8993}, {34.1935, -15.9251}, {16.8632, -37.4707}, {-11.2398, -37.4707}, {-33.2539, -20.6089}, {-33.2539, 6.08899}, {-20.1391, 29.0398}, {-21.0759, 31.8501}, {-20.1391, 29.9766}, {-16.392, 29.9766}, {-20.1391, 32.3185}}, color = {170, 0, 255})}));
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
    Farma.absorbce absorbce1(F = 1) annotation(Placement(visible = true, transformation(origin = {-45, 25}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
    Farma.kompartment kompartment1(C0 = 0, Vd = 100) annotation(Placement(visible = true, transformation(origin = {40, 60}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Farma.kompartment kompartment2(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {47.5, -7.5}, extent = {{-27.5, -27.5}, {27.5, 27.5}}, rotation = 0)));
    Farma.eliminace_nulteho_radu eliminace_nulteho_radu1(CL = 0.1) annotation(Placement(visible = true, transformation(origin = {75, -75}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1) annotation(Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(pulse1.y, absorbce1.u) annotation(Line(points = {{-69, 80}, {-54.6835, 80}, {-54.6835, 44.0506}, {-54.6835, 44.0506}}, color = {0, 0, 127}));
    connect(kompartment2.konektor1, eliminace_nulteho_radu1.konektor1) annotation(Line(points = {{64, -13}, {73.4177, -13}, {73.4177, -47.5949}, {46.5823, -47.5949}, {46.5823, -72.9114}, {68.3544, -72.9114}, {68.3544, -72.9114}}));
    connect(kompartment1.konektor1, kompartment2.konektor1) annotation(Line(points = {{55, 55}, {73.9241, 55}, {73.9241, 9.11392}, {21.2658, 9.11392}, {21.2658, -11.1392}, {41.0127, -11.1392}, {41.0127, -11.1392}}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-18, 7}, {12.1519, 7}, {12.1519, 55.1899}, {34.9367, 55.1899}, {34.9367, 55.1899}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Dvou_kompartmentovy_model;

  model Jedno_kompartmentovy_model_1r
    Farma.absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-65, -65}, {65, 65}}, rotation = 0)));
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = -1) annotation(Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Farma.eliminace_prvniho_radu eliminace_prvniho_radu1(CL = 10) annotation(Placement(visible = true, transformation(origin = {60, -60}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
    Farma.kompartment kompartment1(C0 = 0, Vd = 10) annotation(Placement(visible = true, transformation(origin = {40, 20}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  equation
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-1, -86}, {13.6709, -86}, {13.6709, 10.1266}, {35.443, 13}, {33, 13}}));
    connect(eliminace_prvniho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{50, -58}, {35.9494, -58}, {33, 8}, {33, 13}}));
    connect(absorbce1.u, pulse1.y) annotation(Line(points = {{-53, -34}, {-74.9367, -34}, {-74.9367, -17.2152}, {-53.6709, -17.2152}, {-53.6709, 0}, {-68.3544, 0}, {-68.3544, 0}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Jedno_kompartmentovy_model_1r;

  model Davkovac
    parameter Real Cmin;
    parameter Real Cmax;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, -78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {99, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {80, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    konektor konektor1 annotation(Placement(visible = true, transformation(origin = {2, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, 75}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    konektor1.q = 0;
    if konektor1.conc < Cmin then
      y = 10;
    elseif konektor1.conc > Cmax then
      y = 0;
    else
      y = u;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-3, -3}, fillColor = {187, 206, 12}, fillPattern = FillPattern.Solid, extent = {{-41, 41}, {41, -41}}, endAngle = 360)}));
  end Davkovac;

  model Davkovani_diskretne
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = 10) annotation(Placement(visible = true, transformation(origin = {-84, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    eliminace_prvniho_radu eliminace_prvniho_radu1(CL = 5) annotation(Placement(visible = true, transformation(origin = {90, 28}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
    Davkovac davkovac1(Cmin = 8, Cmax = 18) annotation(Placement(visible = true, transformation(origin = {-42, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {11, 5}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    kompartment kompartment1(C0 = 5, Vd = 20) annotation(Placement(visible = true, transformation(origin = {9, 51}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    connect(absorbce1.konektor1, eliminace_prvniho_radu1.konektor1) annotation(Line(points = {{24, -3}, {56, -3}, {56, 30}, {80, 30}, {80, 30}}));
    connect(davkovac1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-42, 72}, {4, 72}, {4, 46}}));
    connect(kompartment1.konektor1, eliminace_prvniho_radu1.konektor1) annotation(Line(points = {{4, 46}, {56, 46}, {56, 29}, {84, 29}}));
    connect(davkovac1.y, absorbce1.u) annotation(Line(points = {{-34, 56}, {-24, 56}, {-24, 14}, {6, 14}, {6, 14}}, color = {0, 0, 127}));
    connect(pulse1.y, davkovac1.u) annotation(Line(points = {{-73, 68}, {-62, 68}, {-62, 56}, {-50, 56}, {-50, 56}}, color = {0, 0, 127}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_diskretne;

  model P_regulator
    parameter Real Cmin;
    parameter Real Cmax;
    constant Real P;
    Real Cavg;
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-98, 4.88498e-15}, extent = {{-38, -38}, {38, 38}}, rotation = 0), iconTransformation(origin = {-79, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {102, 0}, extent = {{-44, -44}, {44, 44}}, rotation = 0), iconTransformation(origin = {75, -1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  equation
    Cavg = (Cmax + Cmin) / 2;
    y = (Cavg - u) * P;
    annotation(Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2}), graphics = {Ellipse(origin = {-4, -4}, fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-52, 54}, {52, -54}}, endAngle = 360), Text(origin = {-4, 0}, extent = {{-20, 36}, {20, -36}}, textString = "P"), Text(origin = {-1, -71}, extent = {{-75, 21}, {75, -21}}, textString = "%name")}));
  end P_regulator;

  model Davkovani_spojite
    Modelica.Blocks.Sources.Pulse pulse1(amplitude = 10, width = 10, period = 1, nperiod = 10) annotation(Placement(visible = true, transformation(origin = {-82, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    kompartment kompartment1(C0 = 5, Vd = 20) annotation(Placement(visible = true, transformation(origin = {30, 14}, extent = {{-16, -16}, {16, 16}}, rotation = 90)));
    absorbce absorbce1(F = 10) annotation(Placement(visible = true, transformation(origin = {-19, 1}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    eliminace_prvniho_radu eliminace_prvniho_radu1(CL = 5) annotation(Placement(visible = true, transformation(origin = {84, -10}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
    P_regulator p_regulator1(Cmin = 0.08, Cmax = 0.12) annotation(Placement(visible = true, transformation(origin = {-41, 51}, extent = {{-25, -25}, {25, 25}}, rotation = -90)));
  equation
    connect(pulse1.y, p_regulator1.u) annotation(Line(points = {{-71, 82}, {-41, 82}, {-41, 71}}, color = {0, 0, 127}));
    connect(p_regulator1.y, absorbce1.u) annotation(Line(points = {{-41, 32}, {-40, 32}, {-40, 10}, {-24, 10}}, color = {0, 0, 127}));
    connect(eliminace_prvniho_radu1.konektor1, kompartment1.konektor1) annotation(Line(points = {{74, -8}, {33, -8}, {33, 11}}));
    connect(absorbce1.konektor1, kompartment1.konektor1) annotation(Line(points = {{-5, -8}, {33, -8}, {33, 11}}));
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end Davkovani_spojite;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Farma;