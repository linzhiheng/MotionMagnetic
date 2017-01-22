plot(magneticField(:,3)*10^9,'r','LineWidth',2)
hold on
plot(magneticField(:,2)*10^9,'b','LineWidth',2)
hold on
plot(magneticField(:,1)*10^9,'g','LineWidth',2)
set(gca,'YDir','reverse')

xlabel('depth / m')
ylabel('magnetic / nT')
legend('Bz','By','Bx')

% plot(magneticField1(:,3)*10^9,'r','LineWidth',2)
% hold on
% plot(magneticField1(:,2)*10^9,'b','LineWidth',2)
% hold on
% plot(magneticField1(:,1)*10^9,'g','LineWidth',2)
% set(gca,'YDir','reverse')