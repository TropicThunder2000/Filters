fs = 100
t = 0:1/fs:5;
s = sin(2*pi*5*t);
Noisy = randn(size(s))*0.1;
sinew = s+ Noisy;
time = seconds(t);
wave = timetable(time',sinew')
wave = renamevars(wave,"Var1","Sine")

pspectrum(wave,"FrequencyLimits",[0 20])

pspectrum(wave.Sine,wave.Time)

pspectrum(wave.Sine,wave.Time,"spectrogram","FrequencyLimits",[2 20])

[p,f] = pspectrum(wave);

semilogx(f,db(p,"power"))
legend("Sinewave")
xlabel("Frequency HZ")
ylabel("Power Spectrum DB")
xline(0.1)
figure

lowpass(wave(:,"Sine"),0.1)
lowsine = lowpass(wave(:,"Sine"),0.1,"Steepness",0.78)
wave.lowsinewave = lowsine.Sine

figure

highpass(wave(:,"Sine"),0.1)
highsine = highpass(wave(:,"Sine"),0.1,"Steepness",0.99)
wave.highsinewave = highsine.Sine
figure

pspectrum(wave.lowsinewave)
figure
pspectrum(wave.highsinewave)
figure
plot(wave.Time,wave.lowsinewave)
hold on
plot(wave.Time,wave.highsinewave)

xlabel("Time")
title("Low and High waves")
legend("lowpasssine", "highpasssine")
hold off



