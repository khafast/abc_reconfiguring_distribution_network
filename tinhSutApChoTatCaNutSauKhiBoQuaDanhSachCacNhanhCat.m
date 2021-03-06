function danhSachDienApTrenTungNut = tinhSutApChoTatCaNutSauKhiBoQuaDanhSachCacNhanhCat(Udm, cutlist, linedata, powerdataout)
global logLevel
import logging.*
logger = Logger.getLogger('Chuongtrinhchinh');
logger.setLevel(logLevel);
logger.finer('(Start)')

NUT_NGUON = 1;

powerdata = powerdataout;
%cat nhanh cat khoi luoi dien
for vitriNut = 1:length(cutlist)
    m=cutlist(vitriNut) == linedata(:, 1);
    linedata(m, :) = [];
end
danhSachDienApTrenTungNut = zeros(size(powerdata, 1), 2);
danhSachDienApTrenTungNut(:, 1) = powerdata(:, 1);

%Tim duong di
G = taoDoiTuongGraph(linedata);

danhSachNut = bfsearch(G, 1);
m = danhSachDienApTrenTungNut(:, 1)==1;
danhSachDienApTrenTungNut(m, 2) = Udm;
for vitriNut = 2:length(danhSachNut)
    %%Tim nhanh
    nutchay = timDuongDiNganNhatGiuaHaiNut(linedata, NUT_NGUON, danhSachNut(vitriNut));
    for k = 1:size(linedata, 1)
        if (linedata(k,2) == nutchay(1) && linedata(k,3) == nutchay(2)) ||...
           (linedata(k,3) == nutchay(1) && linedata(k,2) == nutchay(2))
            R = linedata(k, 4);
            X = linedata(k, 5);
        end
    end
    %Tim nut truoc
    m = nutchay(1) == powerdata(:,1);
    P = powerdata(m, 2) + powerdata(m, 4);
    Q = powerdata(m, 3) + powerdata(m, 5);
   
    %Tinh do sut ap
    m = nutchay(2) == danhSachDienApTrenTungNut(:,1);
    Udau = danhSachDienApTrenTungNut(m,2);
    DeltaU = (P*R+Q*X)/Udm;
    Ucuoi = Udau-DeltaU/1000;
    
    vitriCuaNutChayTrongDanhSachDienAp = nutchay(1) == danhSachDienApTrenTungNut(:,1);
    danhSachDienApTrenTungNut(vitriCuaNutChayTrongDanhSachDienAp, 2) = Ucuoi;
end
logger.finer('(Success)')
end
