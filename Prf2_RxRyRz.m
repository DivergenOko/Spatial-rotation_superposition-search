function [RF,l,phi]=Prf2_RxRyRz
close all; figure(); axis equal
      V= [2 2 2;
          2 0 2;
          2 0 0;
          2 2 0;
          0 2 0;
          0 2 2;
          0 0 2;
          0 0 0];
      F= [1 2 3 4;
          1 4 5 6;
          5 6 7 8;
          2 3 8 7;
          3 4 5 8;
          2 1 6 7];
            % ���������� ����������� �� stl-�����
            hold on; hP1=patch('Vertices', V, 'Faces', F, 'FaceColor', 'g');hold on; %%%%%%% ���������� ������
            set(hP1,'FaceAlpha', 0.35);
         phi=pi/4;
            RFx=[1 0 0;
                0 cos(phi) -sin(phi);
                0  sin(phi) cos(phi)]; 
            gamma=pi/3;
            RFy=[cos(gamma) 0 sin(gamma);
                     0     1     0;
               -sin(gamma) 0 cos(gamma)];
            delta=-pi/6;
            RFz=[cos(delta)  -sin(delta) 0;
                sin(delta)   cos(delta) 0;
                    0            0      1];
                RF=RFy*RFx*RFz;
%                 RF=RFx;
                
                %%%%%%%%%%%%% ���������� ������������� ��� �������� � ���� ��������
                r1=(V(1,:))'; r2=(V(2,:))';%%%% �������� ����� �������� ���� (��� ��������������� �� ������-�������)
                
                r1str=RF*r1; r2str=RF*r2;  %%% ������ ����� (��� ������-��������) r1, r2 �� ����������� �������� � �������� RF
                
                c=vecprod(r1str-r1,r2str-r2);
                
                l=c/sqrt(c(1)^2+c(2)^2+c(3)^2); %%% ��������� ������, ����� �������� ���������� ��� �������� � ������������ ��� ������� �������� ��������
                
                r1_mod=sqrt(r1(1)^2+r1(2)^2+r1(3)^2);  %%% ������ ������-������� r1
                
                delta0=acos(scalarprod(l,r1)/r1_mod); %%% ���� ����� ���� �������� � �������� r1 (����� �� � ���� ����� ���� �������� � r1str)
                
                d=r1_mod*sin(delta0);%% ���������� �� ����� � ������-�������� r1 �� ��� ��������
                
                phi=2*asin(0.5*sqrt((r1str(1)-r1(1))^2+(r1str(2)-r1(2))^2+(r1str(3)-r1(3))^2)/d); %%%  ������ ���� ��������
                
                if (scalarprod(vecprod(r1,r1str),l)<0)  %%% ���������, ������������� ��� ������������� ������ ���� ���� ����, 
                    %%����������� ���������� �������� r1,r1str � l
                    phi=-phi;
                end
                disp(RF)
            N=size(V,1);
            Vstr=V;
            for i=1:N
                Vstr(i,:)=(RF*(V(i,:))')';
            end
            hold on; hP1=patch('Vertices', Vstr, 'Faces', F, 'FaceColor', 'b');hold on; %%%%%%% ���������� ������
            set(hP1,'FaceAlpha', 0.35);
                %%%%%%% ���������� ���  ��������
             dP=10; O=[0;0;0];
             line([O(1)-dP*l(1) O(1)+dP*l(1)],[O(2)-dP*l(2) O(2)+dP*l(2)],[O(3)-dP*l(3) O(3)+dP*l(3)],...
                 'Color','r','LineWidth',2, 'LineStyle','-.'); axis equal
             xlabel('x','FontSize',12); ylabel('y','FontSize',12);zlabel('z','FontSize',12);