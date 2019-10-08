% write 3 first letters of the input file in the following fields:

%/////////
u='u20';   % wind velocity u
v='v20';   % wind velocity v
t='t20';   % air temperature
um='rh2';  % humidity
p='p20';   % pressure
c='cl2';   % cloud coverage
%//////////


i=0;
f=size(dir);
b=dir;
while i ~= f(1)
 i=i+1;
 
 if length(b(i,1).name) > 2
   if  b(i,1).name(1:3) == u
     disp(b(i,1).name)
     u_calc(b(i,1).name)
   end
   if  b(i,1).name(1:3) == v
     disp(b(i,1).name)
     v_calc(b(i,1).name)
   end
   if  b(i,1).name(1:3) == t
     disp(b(i,1).name)
     temp(b(i,1).name)
   end
   if  b(i,1).name(1:3) == um
     disp(b(i,1).name)
     rhum(b(i,1).name)
   end
   if  b(i,1).name(1:3) == p
     disp(b(i,1).name)
     pressure(b(i,1).name)
   end
   if  b(i,1).name(1:3) == c
     disp(b(i,1).name)
     cloud(b(i,1).name)
   end
  end 
end