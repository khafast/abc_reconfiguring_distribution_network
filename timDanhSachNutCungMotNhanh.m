function danhSachNut = timDanhSachNutCungMotNhanh(linedata, nutdau)
global logLevel
import logging.*
logger = Logger.getLogger('Chuongtrinhchinh');
logger.setLevel(logLevel);
logger.finer(['Tim danh sach nut tren nhanh chua chua nut #' num2str(nutdau) ' (Start)'])

maTranKe = taoMaTranKeDeDanhDauKetNoiGiuaCacNutTrongLinedata(linedata);
G = graph(maTranKe);
D = sum(maTranKe, 2);
nut = nutdau;
danhSachNut = []; %Thung chua nut
danhSachNut(length(danhSachNut) + 1) = nut;
A = 1;
while A == 1
    nutke = neighbors(G, nut);
    %xoa nut da di qua
    for i = 1:length(danhSachNut)
        m = danhSachNut(i) == nutke;
        nutke(m) = [];
    end
    
    nutke(m) = [];
    %Tim duong di den nut khac 2 uu tien qua nut 2
    nut2 = [];
    for i = 1:length(nutke)
        if D(nutke(i)) == 2
           nut2(length(nut2) + 1) = nutke(i);
        end
    end
    
    if isempty(nut2) == 0
        nut = layNgauNhienMotNut(nut2);
        danhSachNut(length(danhSachNut) + 1) = nut;
    else
        nut = layNgauNhienMotNut(nutke);
        danhSachNut(length(danhSachNut) + 1) = nut;
        A = 0;
    end
end

logger.finer(['Tim danh sach nut tren nhanh chua chua nut #' num2str(nutdau) ', danh sach nut la: ' num2str(danhSachNut)])
end

