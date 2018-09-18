linewidthVar = 2.5;
FontSizeLgd = 24;
FontSizeBox = 24;
x = 0:0.01:5;
a = [0.5, 1, 1.2, 2.5, 3];

%% Rayleigh center at mode
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = raylpdf(x, a(i));
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$\alpha = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);

%% Maxwell-Boltzmann center at mode
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = sqrt(2/pi)*(x.^2.*exp(-(x.^2)/(2*(a(i)/sqrt(2))^2)))/(a(i)/sqrt(2))^3;
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$a = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);

%% Exponential center at mean
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = exppdf(x, a(i)^-1);
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$\lambda = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);

%% Gamma center at mode
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = gampdf(x, a(i)^2, a(i)^-1);
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$\alpha = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);

%% Inverse Gamma center at mean
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = gampdf(1./x,a(i)+1,1/a(i)^2)./(x.^2);
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$\alpha = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);

%% Uniform center at mean
figure;
for i=1:size(a,2)
    hold on;
    pdfDistro = unifpdf(x, (1/2)*a(i), (3/2)*a(i));
    plot(x, pdfDistro, 'linewidth', linewidthVar, 'DisplayName',['$a = $',num2str(a(i))]);
end
axis square;
% axis([0 Inf 0 1]);
lgd = legend('Location','northoutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
lgd.FontSize = FontSizeLgd;
set(gca,'FontSize',FontSizeBox, 'Box', 'on', 'linewidth', linewidthVar);