module cpu(input wire clk,
           input wire timer_cpu_tick,
           input wire timer_60hz_tick);

    // TODO: Should this be set from another place?
    reg [15:0] instruction = 0;
    
    reg [15:0] pc = 'h200; // Program counter

    reg [7:0] sp = 0; // Stack pointer
    reg [7:0] dt = 0; // Delay timer
    reg [7:0] st = 0; // Sound timer

    always @(posedge timer_cpu_tick) begin
        casex(instruction)
            // CLS - 00E0 - Clear the display
            16'h00E0: begin

            end

            // RET - 00EE
            // Return from subrutine and pop the top value of the stack and set the program counter to it
            16'h00EE: begin

            end

            // JP addr - 1nnn
            // Jump / set program counter to nnn
            16'h1xxx: begin

            end

            // CALL addr - 2nnn
            // Puts the current pc value on top of the stack and jumps to the addr
            16'h2xxx: begin

            end

            // SE Vx, byte - 3xkk
            // Skips the next instruction if Vx equals kk
            16'h3xxx: begin

            end

            // SNE Vx, byte - 4xkk
            // Skips the next instruction if Vx is not equal kk
            16'h4xxx: begin

            end

            // SE Vx, Vy - 5xy0
            // Skips the next instruction if Vx equals Vy
            16'h5xx0: begin

            end

            // LD Vx, byte - 6xkk
            // Vx = kk
            // Sets register Vx's value to kk
            16'h6xxx: begin

            end

            // ADD Vx, byte - 7xkk
            // Vx = Vx + kk
            // Sets register Vx's value to Vx + kk
            16'h7xxx: begin

            end

            // LD Vx, Vy - 8xy0
            // Vx = Vy
            // Sets register Vx's value to Vy
            16'h8xx0: begin

            end

            // OR Vx, Vy - 8xy1
            // Vx = Vx OR Vy
            // Performes bitwise OR on Vx and Vy and stores in in Vx
            16'h8xx1: begin
    
            end

            // AND Vx, Vy - 8xy2
            // Vx = Vx AND Vy
            // Performes bitwise AND on Vx and Vy and stores in in Vx
            16'h8xx2: begin
    
            end

            // XOR Vx, Vy - 8xy3
            // Vx = Vx XOR Vy
            // Performes bitwise XOR on Vx and Vy and stores in Vx
            16'h8xx3: begin
    
            end

            // ADD Vx, Vy - 8xy4
            // Vx = Vx + Vy, VF = carry
            // Adding up Vx and Vy and stores the result in Vx, sets VF to 1 on overflow otherwise 0
            16'h8xx4: begin
    
            end

            // SUB Vx, Vy - 8xy5
            // Vx = Vx - Vy, VF = NOT borrow
            // Subtracts Vy from Vx and stores the result in in Vx, sets VF to 1 on underflow otherwise 0
            16'h8xx5: begin
    
            end

            // SHR Vx {, Vy} - 8xy6
            // Vx = Vx SHR 1
            // Sets Vx to Vy shifted right by 1, if the LSB of Vx is 1 then VF is set to 1 otherwise 0. Then Vx is divided by 2.
            16'h8xx6: begin
    
            end

            // SUBN Vx, Vy - 8xy7
            // Vx = Vy - Vx, set VF = NOT borrow
            // Subtracts Vx from Vy and stores the result in in Vx, sets VF to 1 on underflow otherwise 0
            16'h8xx7: begin

            end

            // SHL Vx {, Vy} - 8xy8
            // Vx = Vx SHL 1
            // Sets Vx to Vy shifted left by 1, if the MSB of Vx is 1 then VF is set to 1 otherwise 0. Then Vx is multiplied by 2.
            16'h8xx8: begin
    
            end

            // SNE Vx, Vy - 9xy0
            // Skips the next instruction if Vx does not equal Vy
            16'h9xx0: begin
    
            end

            // LD I, addr - Annn
            // Sets the value of register I to nnn
            16'hAxxx: begin

            end

            // JP V0, addr - Bnnn
            // Sets the program counter to V0 + nnn
            16'hBxxx: begin

            end

            // RND Vx, byte - Cxkk
            // Vx = (RANDOM BYTE) AND kk
            // Sets Vx to a random byte bitwise AND'd to kk
            16'hCxxx: begin

            end

            // DRW Vx, Vy, nibble - Dxyn
            // Draws a n byte long sprite located at the I reg memory location at (Vx, Xy). Pixels are copied XOR to detect collisions, if
            // something collides set VF to 1 otherwise 0. If pixels are outside of the framebuffer will it wrap over to the other side
            16'hDxxx: begin

            end

            // SKP Vx - Ex9E
            // Skips the next instruction if the key of register Vx's value is currently down
            16'hEx9E: begin

            end

            // SKNP Vx - ExA1
            // Skips the next instruction if the key of register Vx's value is currently up
            16'hExA1: begin

            end

            // LD Vx, DT - Fx07
            // Sets Vx to the Delay Timer's value
            16'hFx07: begin

            end

            // LD Vx, K - Fx0A
            // Halts all execution until a key is pressed and stores it in Vx
            16'hFx0A: begin

            end

            // LD DT, Vx - Fx15
            // Sets the Delay Timer to Vx
            16'hFx15: begin

            end

            // LD ST, Vx - Fx18
            // Sets the Sound Timer to Vx
            16'hFx18: begin

            end

            // ADD I, Vx - Fx1E
            // I = I + Vx
            // I is set to I + Vx
            16'hFx1E: begin

            end

            // LD F, Vx - Fx29
            // Sets register I to the location of sprite digit Vx.
            16'hFx29: begin

            end

            // LD B, Vx - Fx33
            // Stores the binary coded decimal value of Vx in I, I + 1 and I + 2
            16'hFx33: begin

            end

            // LD [I], Vx - Fx55
            // Stores V0 to Vx starting at reg I's value, I is then set to I + x + 1
            16'hFx55: begin

            end

            // LD Vx, [I] - Fx65
            // Filles V0 to Vx with memory storaed at reg I's value, I is then set to I + x + 1
            16'hFx65: begin

            end
        endcase
    end
endmodule
