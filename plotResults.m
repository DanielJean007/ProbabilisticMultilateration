function plotResults(Distro, nSamples)
%% - Only one data structure at a time. You can't send the whole vector of results from solver here.
Distro = plotCostFunction(Distro);

%% - Plotting the unnormalized posterior 3D
plotInfoOnFig(Distro, Distro.posteriorSurface);
axis square
view(3);
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
zlabel('$\log{g(\mathbf{q})}$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

%% - Plotting the unnormalized posterior Top view
plotInfoOnFig(Distro, Distro.posteriorSurface);
axis square
view(2);
refPts = plot3(Distro.Rn(:,1),Distro.Rn(:,2),15*ones(size(Distro.Rn, 1),size(Distro.Rn, 2)),'ro', 'markersize', 10, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0], 'DisplayName','$\mathbf{r}_i$');
query = plot3(Distro.q(1),Distro.q(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','red','MarkerFaceColor',[1 .5 .9], 'DisplayName','$\mathbf{q}$');
optimum = plot3(Distro.xopt(1),Distro.xopt(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName','$\mathbf{q}_{\textup{MAP}}$');
origin = plot3(Distro.x0(1),Distro.x0(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','blue','MarkerFaceColor',[.5 .9 1], 'DisplayName','$\mathbf{q}_0$');
mean = plot3(Distro.distroMean(1),Distro.distroMean(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.8 .8 .8], 'DisplayName','$\mathbf{q}_{\textup{IS}}$');
meanMH = plot3(Distro.meanMH(1),Distro.meanMH(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[1 .8 .6], 'DisplayName','$\mathbf{q}_{\textup{MH}}$');
lgd = legend([query, origin, refPts(2), optimum, mean, meanMH],'Location','NorthOutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
c = colorbar;
c.LineWidth = 1.5;
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

%% - Plotting the prior
plotInfoOnFig(Distro, Distro.priorSurface);
axis square
view(2);
refPts = plot3(Distro.Rn(:,1),Distro.Rn(:,2),15*ones(size(Distro.Rn, 1),size(Distro.Rn, 2)),'ro', 'markersize', 10, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0], 'DisplayName','$\mathbf{r}_i$');
query = plot3(Distro.q(1),Distro.q(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','red','MarkerFaceColor',[1 .5 .9], 'DisplayName','$\mathbf{q}$');
optimum = plot3(Distro.xopt(1),Distro.xopt(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName','$\mathbf{q}_{\textup{MAP}}$');
origin = plot3(Distro.x0(1),Distro.x0(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','blue','MarkerFaceColor',[.5 .9 1], 'DisplayName','$\mathbf{q}_0$');
mean = plot3(Distro.distroMean(1),Distro.distroMean(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.8 .8 .8], 'DisplayName','$\mathbf{q}_{\textup{IS}}$');
meanMH = plot3(Distro.meanMH(1),Distro.meanMH(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[1 .8 .6], 'DisplayName','$\mathbf{q}_{\textup{MH}}$');
lgd = legend([query, origin, refPts(2), optimum, mean, meanMH],'Location','NorthOutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
c = colorbar;
c.LineWidth = 1.5;
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

%% - Plotting the likelihood
plotInfoOnFig(Distro, Distro.likelihoodSurface);
axis square
view(2);
refPts = plot3(Distro.Rn(:,1),Distro.Rn(:,2),15*ones(size(Distro.Rn, 1),size(Distro.Rn, 2)),'ro', 'markersize', 10, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0], 'DisplayName','$\mathbf{r}_i$');
query = plot3(Distro.q(1),Distro.q(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','red','MarkerFaceColor',[1 .5 .9], 'DisplayName','$\mathbf{q}$');
optimum = plot3(Distro.xopt(1),Distro.xopt(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName','$\mathbf{q}_{\textup{MAP}}$');
origin = plot3(Distro.x0(1),Distro.x0(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','blue','MarkerFaceColor',[.5 .9 1], 'DisplayName','$\mathbf{q}_0$');
mean = plot3(Distro.distroMean(1),Distro.distroMean(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.8 .8 .8], 'DisplayName','$\mathbf{q}_{\textup{IS}}$');
meanMH = plot3(Distro.meanMH(1),Distro.meanMH(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[1 .8 .6], 'DisplayName','$\mathbf{q}_{\textup{MH}}$');
lgd = legend([query, origin, refPts(2), optimum, mean, meanMH],'Location','NorthOutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
c = colorbar;
c.LineWidth = 1.5;
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

%% - Plotting the normalized distribution 3D
NewDistro = CompEvidence(Distro, nSamples, 1);
axis square
view(3);
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
zlabel('$p(\mathbf{q} \mid \mathbf{d}, \mathbf{r})$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

%% - Plotting the normalized distribution Top view
plotInfoOnFig(NewDistro, NewDistro.surfaceNorm);
axis square
view(2);
refPts = plot3(Distro.Rn(:,1),Distro.Rn(:,2),15*ones(size(Distro.Rn, 1),size(Distro.Rn, 2)),'ro', 'markersize', 10, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0], 'DisplayName','$\mathbf{r}_i$');
query = plot3(Distro.q(1),Distro.q(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','red','MarkerFaceColor',[1 .5 .9], 'DisplayName','$\mathbf{q}$');
optimum = plot3(Distro.xopt(1),Distro.xopt(2), 15,'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.2 1 .5], 'DisplayName','$\mathbf{q}_{\textup{MAP}}$');
origin = plot3(Distro.x0(1),Distro.x0(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','blue','MarkerFaceColor',[.5 .9 1], 'DisplayName','$\mathbf{q}_0$');
mean = plot3(Distro.distroMean(1),Distro.distroMean(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[.8 .8 .8], 'DisplayName','$\mathbf{q}_{\textup{IS}}$');
meanMH = plot3(Distro.meanMH(1),Distro.meanMH(2), 15, 'o','MarkerSize',20,'MarkerEdgeColor','k','MarkerFaceColor',[1 .8 .6], 'DisplayName','$\mathbf{q}_{\textup{MH}}$');
lgd = legend([query, origin, refPts(2), optimum, mean, meanMH],'Location','NorthOutside','Orientation','horizontal');
lgd.Interpreter = 'latex';
c = colorbar;
c.LineWidth = 1.5;
xlabel('$q_1$','Interpreter','latex','FontSize',24);
ylabel('$q_2$','Interpreter','latex','FontSize',24);
zlabel('$p(\mathbf{q} \mid \mathbf{d}, \mathbf{r})$','Interpreter','latex','FontSize',24);
set(gca,'FontSize',24, 'Box', 'on', 'linewidth', 1.5);

end