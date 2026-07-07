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
| `mode` | Input | 1 bit | Lựa chọn chế độ: `1` = Mã hóa (Encrypt), `0` = Giải mã (Decrypt). |
| `din` | Input | 128 bit | Bus dữ liệu đầu vào (Plaintext / Ciphertext). |
| `dout` | Output| 128 bit | Bus dữ liệu đầu ra (Ciphertext / Plaintext). |
| `ready` | Output| 1 bit | Báo hiệu IP Core đang rảnh (Idle), sẵn sàng nhận lệnh mới. |
| `done` | Output| 1 bit | Báo hiệu dữ liệu đầu ra `dout` hợp lệ (tích cực trong 1 chu kỳ). |

---

## 3. Thông Số Cấu Hình PnR (PnR Flow Parameters)

Quy trình thiết kế vật lý PnR được cấu hình thông qua [config.json](file:///home/tienpnh/workspace/librelane/my_designs/aes256/config.json) với các thông số tối ưu hóa thời gian và không gian đi dây (timing & routing closure):

* **Thư viện công nghệ (Technology PDK):** SkyWater 130nm (`sky130A`), thư viện cell chuẩn High-Density (`sky130_fd_sc_hd`).
* **Chu kỳ Clock mục tiêu (Clock Period):** **`25.0 ns`** (Tương đương tần số hoạt động **40 MHz** trên Silicon thực tế).
* **Mật độ sử dụng lõi mục tiêu (Core Utilization):** **`30%`** (Tỷ lệ phân bổ diện tích tối ưu, giúp tăng lượng kênh dẫn trống để router đi dây tín hiệu, triệt tiêu hoàn toàn nghẽn mạch routing congestion).
* **Xử lý tín hiệu Clock:** Tự động tổng hợp Clock Tree Synthesis (CTS) để cấp phát xung nhịp đồng đều đến toàn bộ các Flip-Flops.

---

## 4. Kết Quả Thực Tế Sau Thiết Kế Vật Lý (Physical Implementation Metrics)

Sau khi chạy hoàn chỉnh 80 bước của luồng tự động hóa vật lý từ tổng hợp logic đến kiểm định sản xuất, các số liệu thực tế thu được như sau:

### Diện Tích Silicon (Silicon Area):
* **Tổng diện tích Die (Die Area):** **`842.209 µm²`** (Kích thước đường bao: $912.375\text{ µm} \times 923.095\text{ µm}$, tương đương $\approx 0.84\text{ mm²}$).
* **Diện tích Core (Core Area):** **`811.314 µm²`**.
* **Mật độ sử dụng cổng chuẩn thực tế (Standard Cell Utilization):** **`41.97%`**.

### Thống Kê Linh Kiện (Gate Count & Cells):
* **Số lượng cổng logic chuẩn (Standard Cell Instances):** **`41.874 cells`** (Không bao gồm các ô điền đầy fill cells).
* **Thanh ghi đồng bộ (Sequential Flip-Flops):** **`2.323 FFs`** (Phục vụ cho các khối FSM điều khiển và đệm dữ liệu vòng lặp).
* **Cổng đệm sửa lỗi Timing (Hold/Setup Buffers):** Tự động chèn **`2.055 hold-buffers`** và **`7.939 timing-repair buffers`** để bảo toàn chất lượng tín hiệu.

### Điện Năng Tiêu Thụ (Power Consumption):
* **Công suất chuyển mạch động (Switching Power):** **`79.62 mW`** ($58.1\%$).
* **Công suất nội tại cổng (Internal Power):** **`57.35 mW`** ($41.9\%$).
* **Công suất dòng rò tĩnh (Leakage Power):** **`0.81 µW`** ($<0.01\%$).
* **Tổng công suất tiêu thụ ước tính (Total Power):** **`136.97 mW`**.

### Thời Gian Đáp Ứng (Timing Slack):
* **Setup Slack:** **`7.546 ns`** (Dương hoàn toàn, đạt chỉ tiêu timing setup).
* **Hold Slack:** **`0.318 ns`** (Dương hoàn toàn, đạt chỉ tiêu timing hold).
* **Worst Negative Slack (WNS):** **`0.00 ns`** (Không có bất kỳ đường trễ âm nào trên toàn bộ chip).

### Kiểm Định Vật Lý Sản Xuất (Signoff Verification):
* **Antenna Rule Check:** **`ĐẠT (Passed ✅)`** — Bảo vệ tốt oxide cổng của các transistor chống lại dòng điện tĩnh trong quá trình ăn mòn kim loại sản xuất.
* **LVS (Layout vs Schematic):** **`ĐẠT (Passed ✅)`** — Đảm bảo cấu trúc vật lý sau PnR hoàn toàn trùng khớp với thiết kế nguyên lý.
* **DRC (Design Rule Checks):** **`ĐẠT (Passed ✅)`** — Đạt chuẩn tuyệt đối mọi khoảng cách hình học, kim loại, lỗ via theo quy tắc của SkyWater Foundry.

---

## 5. Cấu Trúc Các Tệp Tin Đầu Ra Vật Lý (Output Directory Structure)

Toàn bộ các file kết quả thiết kế vật lý lớp cuối cùng (Views) được lưu trữ tại thư mục: **`my_designs/aes256/runs/RUN_2026-07-07_07-22-59/final/`**

```
final/
├── gds/              # Chứa tệp layout aes_core_256.gds định dạng GDSII (dùng để gửi nhà máy làm mặt nạ hàn chip)
├── vh/               # Netlist cổng logic (Gate-level Netlist) dạng Verilog sau PnR
├── sdf/              # Tệp Standard Delay Format chứa toàn bộ trễ của cổng và dây dẫn (phục vụ mô phỏng Timing)
├── spef/             # Tệp ký sinh điện trở, điện dung dây dẫn (Standard Parasitic Extraction Format)
├── spice/            # Netlist SPICE đầy đủ các chân nguồn (dùng để kiểm tra LVS)
├── sdc/              # Bản sao file ràng buộc timing đầu ra
├── def/              # File mô tả vị trí cell và đường đi dây (Design Exchange Format)
├── lef/              # File thư viện hình học của IP Core (Library Exchange Format)
├── metrics.json      # Báo cáo chi tiết mọi chỉ số diện tích, công suất, timing của thiết kế dạng JSON
└── metrics.csv       # Báo cáo chi tiết dạng CSV
```
