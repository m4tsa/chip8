module memory(input wire clk,
              input wire read,
              input wire [11:0] read_addr,
              output reg [7:0] read_data = 0,
              output reg read_ack = 0,
              input wire write,
              input wire [11:0] write_addr,
              input wire [7:0] write_data,
              // GPU inputs
              input wire gpu_read,
              input wire [11:0] gpu_read_addr,
              output reg [7:0] gpu_read_data = 0,
              output reg gpu_read_ack = 0,
              input wire gpu_write,
              input wire [11:0] gpu_write_addr,
              input wire [7:0] gpu_write_data,
              // VGA data
              input wire vga_read,
              input wire [11:0] vga_addr,
              output reg [7:0] vga_data = 0
           );

    parameter MEMORY_SIZE = 4096;

    reg [7:0] mem[0:MEMORY_SIZE - 1];

    integer i;
    initial begin
        for (i = 0; i < 4096; i = i + 1) begin
            mem[i] = 0;
        end
    end

    // Put the font data in the upper part of the reserved memory
    initial $readmemh("assets/font.hex", mem, 0, 'h4F);
    // ROM for PONG
    initial $readmemh("assets/pong.hex", mem, 'h200);

    // Main memory
    always @(posedge clk) begin
        // Reset acknowledgement
        read_ack <= 0;
        gpu_read_ack <= 0;

        // Read memory
        if (read) begin
            read_data <= mem[read_addr];
            read_ack <= 1;
        end

        if (gpu_read) begin
            gpu_read_data <= mem[gpu_read_addr];
            gpu_read_ack <= 1;
        end

        if (vga_read) begin
            vga_data <= mem[vga_addr];
        end

        // Having multiple mem storing statements will break Quartus' synth, but this seems to work
        // The CPU will never write anything while the GPU is working so this should not cause any issues
        if (write || gpu_write) begin
            mem[gpu_write ? gpu_write_addr : write_addr] <= gpu_write ? gpu_write_data : write_data;
        end
    end
endmodule
