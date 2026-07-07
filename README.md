# IP Core AES-256 (Physical Implementation with LibreLane)

Dự án này chứa mã nguồn RTL Verilog và toàn bộ cấu hình, kết quả thiết kế vật lý (**Place & Route - PnR**) của lõi IP Core **AES-256 (aes_core_256)** sử dụng bộ công cụ **LibreLane** trên công nghệ **SkyWater 130nm (sky130A)**.

Thiết kế đã được tối ưu hóa thành công, vượt qua toàn bộ các bước kiểm tra chất lượng sản xuất vật lý (**Signoff Verification**) bao gồm DRC, LVS và Antenna.

---

## 1. Kiến Trúc Bộ Mã Hóa/Giải Mã AES-256

Lõi IP Core `aes_core_256` tuân thủ hoàn toàn tiêu chuẩn mật mã **NIST FIPS 197**. Thiết kế áp dụng kiến trúc **Sub-pipelining** để tối ưu hóa tần số hoạt động cực đại ($F_{max}$) và dễ dàng tích hợp vào các hệ thống System-on-Chip (SoC).

### Kiến Trúc Sub-Pipelining:
Mỗi vòng xử lý (Round) tiêu chuẩn của AES được chia đôi thành 2 pha (`Phase A` và `Phase B`) nhờ thanh ghi đệm trung gian `state_mid_reg` chèn vào sau bước dịch hàng (`ShiftRows`):
* **Phase A:** `State` $\to$ `SubBytes` $\to$ `ShiftRows` $\to$ `state_mid_reg` (Sườn clock 1).
* **Phase B:** `state_mid_reg` $\to$ `MixColumns` $\to$ `AddRoundKey` $\to$ `State` (Sườn clock 2).

### Chu Kỳ Xử Lý (Latency):
Tổng số chu kỳ clock để hoàn thành mã hóa hoặc giải mã một khối dữ liệu 128-bit là **30 chu kỳ clock**:
$$\text{Latency} = 1 \text{ (Round 0)} + 26 \text{ (Rounds 1-13 } \times 2) + 2 \text{ (Round 14 } \times 2) + 1 \text{ (Done)} = 30 \text{ chu kỳ}$$

---

## 2. Đặc Tả Giao Diện Tín Hiệu (Interface Ports)

| Tên Tín Hiệu | Hướng | Kích Thước | Mô Tả |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1 bit | Xung clock hệ thống (tác động sườn dương). |
| `reset_n` | Input | 1 bit | Reset không đồng bộ (tích cực mức thấp). |
| `key_load` | Input | 1 bit | Kích hoạt nạp khóa chính và chạy Key Expansion. |
| `key_in` | Input | 256 bit | Bus nạp khóa chính 256-bit. |
| `key_ready`| Output| 1 bit | Báo hiệu quá trình mở rộng khóa đã xong, sẵn sàng làm việc. |
| `start` | Input | 1 bit | Kích hoạt mã hóa/giải mã một khối dữ liệu mới. |
| `mode` | Input | 1 bit | Lựa chọn chế độ: `1` = Mã hóa (Encrypt), `0` = Giải mã (Decrypt). |## 3. Thông Số Cấu Hình PnR (PnR Flow Parameters)

Quy trình thiết kế vật lý PnR được cấu hình thông qua [config.json](file:///home/tienpnh/workspace/librelane/my_designs/aes256/config.json) với các thông số tối ưu hóa thời gian và không gian đi dây (timing & routing closure):

* **Thư viện công nghệ (Technology PDK):** SkyWater 130nm (`sky130A`), thư viện cell chuẩn High-Density (`sky130_fd_sc_hd`).
* **Chu kỳ Clock mục tiêu (Clock Period):** **`25.0 ns`** (Tương đương tần số hoạt động **40 MHz** trên Silicon thực tế).
* **Mật độ sử dụng lõi mục tiêu (Core Utilization):** **`40%`** (Tỷ lệ phân bổ diện tích tối ưu giúp đảm bảo độ thoáng cho kênh dẫn đi dây, khắc phục triệt để nghẽn mạch routing congestion).
* **Xử lý tín hiệu Clock & Ràng buộc:** Tự động tổng hợp Clock Tree Synthesis (CTS), sửa lỗi timing setup/hold và khắc phục lỗi antenna thông qua diode insertion.

---

## 4. Kết Quả Thực Tế Sau Thiết Kế Vật Lý (Physical Implementation Metrics)

Sau khi chạy hoàn chỉnh 80 bước của luồng tự động hóa vật lý từ tổng hợp logic đến kiểm định sản xuất, các số liệu thực tế thu được như sau:

### Diện Tích Silicon (Silicon Area):
* **Tổng diện tích Die (Die Area):** **`635,148 µm²`** (Kích thước đường bao: $791.62\text{ µm} \times 802.34\text{ µm}$, tương đương $\approx 0.635\text{ mm²}$).
* **Diện tích Core (Core Area):** **`606,902 µm²`** (Kích thước đường bao: $785.68\text{ µm} \times 788.8\text{ µm}$).
* **Mật độ sử dụng cổng chuẩn thực tế (Standard Cell Utilization):** **`55.22%`** (Bao gồm diện tích logic và các buffer timing/antennas chèn thêm).

### Thống Kê Linh Kiện (Gate Count & Cells):
* **Số lượng cổng logic chuẩn (Standard Cell Instances):** **`38,885 cells`** (Không bao gồm các ô điền đầy fill cells và tap cells).
* **Thanh ghi đồng bộ (Sequential Flip-Flops):** **`2,323 FFs`**.
* **Cổng đệm sửa lỗi Timing (Hold/Setup Buffers):** Tự động chèn **`2,057 hold-buffers`** và **`7,817 timing-repair buffers`** để bảo toàn chất lượng tín hiệu.
* **Tế bào chống lỗi Antenna (Antenna Cells & Diodes):** Chèn **`215 antenna cells`** (chứa **`100`** đi-ốt bảo vệ).

### Điện Năng Tiêu Thụ (Power Consumption - nom_tt_025C_1v80):
* **Công suất chuyển mạch động (Switching Power):** **`78.34 mW`** ($57.9\%$).
* **Công suất nội tại cổng (Internal Power):** **`56.95 mW`** ($42.1\%$).
* **Công suất dòng rò tĩnh (Leakage Power):** **`0.61 µW`** ($<0.01\%$).
* **Tổng công suất tiêu thụ ước tính (Total Power):** **`135.29 mW`**.

### Thời Gian Đáp Ứng (Timing Slack - typical corner nom_tt_025C_1v80):
* **Setup Slack:** **`7.219 ns`** (Dương hoàn toàn, đạt chỉ tiêu timing setup).
* **Hold Slack:** **`0.334 ns`** (Dương hoàn toàn, đạt chỉ tiêu timing hold).
* **Worst Negative Slack (WNS) / Total Negative Slack (TNS):** **`0.00 ns`** (Không có bất kỳ đường trễ âm nào trên toàn bộ chip ở góc làm việc điển hình).

### Kiểm Định Vật Lý Sản Xuất (Signoff Verification):
* **Antenna Rule Check:** **`ĐẠT (Passed ✅)`** — Bảo vệ tốt oxide cổng của các transistor chống lại dòng điện tĩnh trong quá trình chế tạo.
* **LVS (Layout vs Schematic):** **`ĐẠT (Passed ✅)`** — Đảm bảo cấu trúc vật lý sau PnR hoàn toàn trùng khớp với thiết kế nguyên lý.
* **DRC (Design Rule Checks):** **`ĐẠT (Passed ✅)`** — Đạt chuẩn tuyệt đối mọi quy tắc khoảng cách hình học của nhà máy SkyWater.

---

## 5. Cấu Trúc Các Tệp Tin Đầu Ra Vật Lý (Output Directory Structure)

Toàn bộ các file kết quả thiết kế vật lý lớp cuối cùng (Views) và báo cáo (Reports) được tổ chức tại thư mục gốc của thiết kế:

```
my_designs/aes256/
├── final/              # Chứa tệp layout và netlist vật lý cuối cùng
│   ├── gds/            # Layout GDSII cuối cùng (để gửi nhà máy làm mặt nạ hàn chip)
│   ├── vh/             # Netlist cổng logic (Gate-level Netlist) sau PnR
│   ├── sdf/            # Ràng buộc trễ Standard Delay Format phục vụ mô phỏng timing
│   ├── spef/           # Ký sinh điện trở, điện dung dây dẫn (Standard Parasitic Extraction)
│   ├── spice/          # Netlist SPICE đầy đủ các chân nguồn (kiểm tra LVS)
│   ├── sdc/            # Bản sao file ràng buộc timing đầu ra
│   ├── def/            # File mô tả vị trí cell và đường đi dây (Design Exchange Format)
│   ├── lef/            # File thư viện hình học của IP Core (Library Exchange Format)
│   ├── metrics.json    # Báo cáo chi tiết mọi chỉ số diện tích, công suất, timing của thiết kế dạng JSON
│   └── metrics.csv     # Báo cáo chi tiết dạng CSV
├── output/             # Thư mục chứa các báo cáo đo đạc chi tiết (Reports)
│   ├── timing_summary.rpt  # Báo cáo tổng hợp timing (Setup/Hold slack từng corner)
│   ├── power.rpt           # Báo cáo chi tiết công suất tiêu thụ điện tĩnh và động
│   ├── irdrop.rpt          # Báo cáo sụt giảm điện áp nguồn (IR Drop)
│   ├── drc.magic.rpt       # Báo cáo kiểm định thiết kế hình học (DRC) từ Magic
│   ├── lvs.netgen.rpt      # Báo cáo so khớp Layout vs Schematic từ Netgen
│   └── manufacturability.rpt # Báo cáo tổng hợp khả năng chế tạo (Antenna, DRC, LVS)
```
