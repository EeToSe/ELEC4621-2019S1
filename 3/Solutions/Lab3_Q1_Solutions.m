%% Lab 3 Q1 Solutions
% Written by Antoni Dimitriadis.

%% Q1a

clear variables;
close all;

dc_gain = 1 + 0.33 + -0.162 + -0.3312 + -0.1296;

% dc gain = 0.7072

%% Q1b

zh = roots([1 0.33 -0.162 -0.3312 -0.1296]);

% Note some zeros are in conjugate pairs

%% Q1c

% There are 2^3 possible (real) filters with the same magnitude response, since
% the complex conjugate roots must be inverted together if we wish the
% coefficients to remain real.

theta = linspace(-pi,pi,10000);
z= exp(1j*theta);

H = @(z1,z2,z3,z4) (z-z1).*(z-z2).*(z-z3).*(z-z4)./((1-z1)*(1-z2)*(1-z3)*(1-z4)*z.^4);

H1 = H(zh(1), zh(2), zh(3), zh(4));
H2 = H(1/zh(1), zh(2), zh(3), zh(4));
H3 = H(zh(1), 1/zh(2), 1/zh(3), zh(4));
H4 = H(zh(1), zh(2), zh(3), 1/zh(4));
H5 = H(1/zh(1), 1/zh(2), 1/zh(3), zh(4));
H6 = H(1/zh(1), zh(2), zh(3), 1/zh(4));
H7 = H(zh(1), 1/zh(2), 1/zh(3), 1/zh(4));
H8 = H(1/zh(1), 1/zh(2), 1/zh(3), 1/zh(4));

figure('Name', "Magnitude spectrum plots");
plot(theta, abs(H1));
hold on;
plot(theta, abs(H2));
hold on;
plot(theta, abs(H3));
hold on;
plot(theta, abs(H4));
hold on;
plot(theta, abs(H5));
hold on;
plot(theta, abs(H6));
hold on;
plot(theta, abs(H7));
hold on;
plot(theta, abs(H8));
title("Magnitude responses of various phase combination filters");
xlabel("Digital frequency (rad)")

% They are all the same

%% Q1e

figure('Name', "Phase plots");
title("Phase responses of various phase combination filters");
hold on;
plot(theta, unwrap(angle(H1)));
hold on;
plot(theta, unwrap(angle(H2)));
hold on;
plot(theta, unwrap(angle(H3)));
hold on;
plot(theta, unwrap(angle(H4)));
hold on;
plot(theta, unwrap(angle(H5)));
hold on;
plot(theta, unwrap(angle(H6)));
hold on;
plot(theta, unwrap(angle(H7)));
hold on;
plot(theta, unwrap(angle(H8)));
xlabel("Digital frequency (rad)");
legend("H1","H2","H3","H4","H5","H6","H7","H8");

% H8 is very steep, H1 is very shallow

%% Q1f

tg1 = unwrap(angle(H1)) - circshift(unwrap(angle(H1)), 1);
tg2 = unwrap(angle(H2)) - circshift(unwrap(angle(H2)), 1);
tg3 = unwrap(angle(H3)) - circshift(unwrap(angle(H3)), 1);
tg4 = unwrap(angle(H4)) - circshift(unwrap(angle(H4)), 1);
tg5 = unwrap(angle(H5)) - circshift(unwrap(angle(H5)), 1);
tg6 = unwrap(angle(H6)) - circshift(unwrap(angle(H6)), 1);
tg7 = unwrap(angle(H7)) - circshift(unwrap(angle(H7)), 1);
tg8 = unwrap(angle(H8)) - circshift(unwrap(angle(H8)), 1);

figure('Name', "Group delay plots");
title("Magnitude responses of various phase combination filters");
plot(theta(2:end), -tg1(2:end));
hold on;
plot(theta(2:end), -tg2(2:end));
hold on;
plot(theta(2:end), -tg3(2:end));
hold on;
plot(theta(2:end), -tg4(2:end));
hold on;
plot(theta(2:end), -tg5(2:end));
hold on;
plot(theta(2:end), -tg6(2:end));
hold on;
plot(theta(2:end), -tg7(2:end));
hold on;
plot(theta(2:end), -tg8(2:end));
xlabel("Digital frequency (rad)");
legend("tg1","tg2","tg3","tg4","tg5","tg6","tg7","tg8");

% H1 has the smallest group delay because it is the minimum phase filter,
% all it's zeros are inside the unit circle.

%% Q1g

dc_gain = 1 + -0.26949 + 3.9307 + -0.26949 + 1;

% dc gain is 5.3917

zh = roots([1 -0.26949 3.9307 -0.26949 1]);

% Note: zeros are in conjugate pairs
% Also note: the first pair are the multiplicative inverse of the second pair
% There are 2^2 possible (real) filters with the same magnitude response, since
% the complex conjugate roots must be inverted together if we wish the
% coefficients to remain real.

H = @(z1,z2,z3,z4) (z-z1).*(z-z2).*(z-z3).*(z-z4)./((1-z1)*(1-z2)*(1-z3)*(1-z4)*z.^4);

H1 = H(zh(1), zh(2), zh(3), zh(4));
H2 = H(1/zh(1), 1/zh(2), zh(3), zh(4));
H3 = H(zh(1), zh(2), 1/zh(3), 1/zh(4));
H4 = H(1/zh(1), 1/zh(2), 1/zh(3), 1/zh(4));

figure('Name', "Magnitude spectrum plots");
plot(theta, abs(H1));
hold on;
plot(theta, abs(H2));
hold on;
plot(theta, abs(H3));
hold on;
plot(theta, abs(H4));
title("Magnitude responses of various phase combination filters");
xlabel("Digital frequency (rad)")

% They are all the same

figure('Name', "Phase plots");
title("Phase responses of various phase combination filters");
hold on;
plot(theta, unwrap(angle(H1)));
hold on;
plot(theta, unwrap(angle(H2)));
hold on;
plot(theta, unwrap(angle(H3)));
hold on;
plot(theta, unwrap(angle(H4)));
xlabel("Digital frequency (rad)");
legend("H1","H2","H3","H4");

% H3 is very steep, H2 is very shallow, H1 is under H4

tg1 = unwrap(angle(H1)) - circshift(unwrap(angle(H1)), 1);
tg2 = unwrap(angle(H2)) - circshift(unwrap(angle(H2)), 1);
tg3 = unwrap(angle(H3)) - circshift(unwrap(angle(H3)), 1);
tg4 = unwrap(angle(H4)) - circshift(unwrap(angle(H4)), 1);

figure('Name', "Group delay plots");
title("Magnitude responses of various phase combination filters");
plot(theta(2:end), -tg1(2:end));
hold on;
plot(theta(2:end), -tg2(2:end));
hold on;
plot(theta(2:end), -tg3(2:end));
hold on;
plot(theta(2:end), -tg4(2:end));
xlabel("Digital frequency (rad)");
legend("tg1","tg2","tg3","tg4");

% H2 has the smallest group delay because it is the minimum phase filter,
% all it's zeros are inside the unit circle.

