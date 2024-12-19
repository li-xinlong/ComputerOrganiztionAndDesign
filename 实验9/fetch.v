`timescale 1ns / 1ps
//*************************************************************************
//   > �ļ���: fetch.v
//   > ����  :�弶��ˮCPU��ȡָģ��
//   > ����  : LOONGSON
//   > ����  : 2016-04-14
//*************************************************************************
`define STARTADDR 32'H00000034   // ������ʼ��ַΪ34H
module fetch(                    // ȡָ��
    input             clk,       // ʱ��
    input             resetn,    // ��λ�źţ��͵�ƽ��Ч
    input             IF_valid,  // ȡָ����Ч�ź�
    input             next_fetch,// ȡ��һ��ָ���������PCֵ
    input      [31:0] inst,      // inst_romȡ����ָ��
    input      [32:0] jbr_bus,   // ��ת����
    output     [31:0] inst_addr, // ����inst_rom��ȡָ��ַ
    output         IF_over,   // IFģ��ִ�����
    output     [63:0] IF_ID_bus, // IF->ID����
    
    //5����ˮ�����ӿ�
    input      [32:0] exc_bus,   // Exception pc����
        
    //չʾPC��ȡ����ָ��
    output     [31:0] IF_pc,
    output     [31:0] IF_inst,
    output     [31:0] print_prior_seq_pc,
    output            print_jbr_taken,
    output            prior_predict_jbr_taken
);

//-----{���������PC}begin
    wire [31:0] next_pc;
    wire [31:0] seq_pc;
    reg  [31:0] pc;
    
    //��תpc
    wire        jbr_taken;
    wire [31:0] jbr_target;
    assign {jbr_taken, jbr_target} = jbr_bus;  // ��ת���ߴ��Ƿ���ת��Ŀ���ַ
    assign print_jbr_taken=jbr_taken;
    //Exception PC
    wire        exc_valid;
    wire [31:0] exc_pc;
    assign {exc_valid,exc_pc} = exc_bus;
    
    //pc+4
    assign seq_pc[31:2]    = pc[31:2] + 1'b1;  // ��һָ���ַ��PC=PC+4
    assign seq_pc[1:0]     = pc[1:0];

//-----{��֧Ԥ��}begin
//��֧Ԥ��: ���г��Ĵ�����תָ��֮��ķ�֧��תָ��
wire [5:0] op;     
wire [4:0] rs; 
wire [4:0] rt;   
wire [4:0] rd;       
wire [4:0] sa;      
wire [5:0] funct;    
wire op_zero;  // ������ȫ0
wire sa_zero;  // sa��ȫ0
wire inst_J, inst_JAL, inst_JALR, inst_JR;
wire inst_BEQ, inst_BGEZ, inst_BGTZ, inst_BLEZ, inst_BLTZ, inst_BNE;
    
assign op     = inst[31:26];  // ������
assign rs     = inst[25:21];  // Դ������1
assign rt     = inst[20:16];  // Դ������2
assign rd     = inst[15:11];  // Ŀ�������
assign sa     = inst[10:6];   // �����򣬿��ܴ��ƫ����
assign funct  = inst[5:0];    // ������
assign op_zero = ~(|op);
assign sa_zero = ~(|sa);
assign inst_J     = (op == 6'b000010);             //��ת
assign inst_JAL   = (op == 6'b000011);             //��ת������
assign inst_JALR  = op_zero & (rt==5'd0) & (rd==5'd31)
                  & sa_zero & (funct == 6'b001001);         //��ת�Ĵ���������
assign inst_JR    = op_zero & (rt==5'd0) & (rd==5'd0 )
                  & sa_zero & (funct == 6'b001000);             //��ת�Ĵ���
assign inst_BEQ   = ~op_zero & (op == 6'b000100);             //�ж������ת
assign inst_BGEZ  = ~op_zero & (op == 6'b000001) & (rt==5'd1);//���ڵ���0��ת
assign inst_BGTZ  = ~op_zero & (op == 6'b000111) & (rt==5'd0);//����0��ת
assign inst_BLEZ  = ~op_zero & (op == 6'b000110) & (rt==5'd0);//С�ڵ���0��ת
assign inst_BLTZ  = ~op_zero & (op == 6'b000001) & (rt==5'd0);//С��0��ת
assign inst_BNE   = ~op_zero & (op == 6'b000101);             //�жϲ�����ת

wire inst_jr;    //�Ĵ�����תָ��
assign inst_jr     = inst_JALR | inst_JR;
wire [31:0] j_target;
wire [31:0] bd_pc;
wire j_taken;
wire br_taken;
assign bd_pc = inst_addr + 3'b100;
assign j_target = {bd_pc[31:28],inst[25:0],2'b00};
assign j_taken = inst_J | inst_JAL;
assign br_taken = inst_BEQ | inst_BNE | inst_BGEZ | inst_BGTZ | inst_BLEZ | inst_BLTZ;
wire [15:0] offset;
assign offset = inst[15:0];
wire [31:0] br_target;
wire predict_jbr_taken;
wire [31:0] predict_jbr_target;
assign br_target[31:2] = bd_pc[31:2] + {{14{offset[15]}}, offset};  
assign br_target[1:0]  = bd_pc[1:0];
assign predict_jbr_taken = j_taken | br_taken; 
assign predict_jbr_target = j_taken ? j_target : br_target;

reg prior_predict_jbr_taken;
reg prior_is_inst_jr;
reg [31:0] prior_seq_pc;
always @(posedge clk)   
begin
    prior_predict_jbr_taken <= predict_jbr_taken;
    prior_is_inst_jr <= inst_jr;
    prior_seq_pc <= seq_pc;
end
assign  print_prior_seq_pc = prior_seq_pc ;

assign  print_prior_predict_jbr_taken=prior_predict_jbr_taken;
//-----{��֧Ԥ��}end

    // ��ָ�����Exception,��PCΪExceptio��ڵ�ַ
    //         ��ָ����ת����PCΪ��ת��ַ������Ϊpc+4
    assign next_pc = exc_valid ? exc_pc : 
                     jbr_taken ? jbr_target : seq_pc;
//assign next_pc = exc_valid ? exc_pc : 
//                 (prior_predict_jbr_taken & ~jbr_taken) ? prior_seq_pc :
//                 (prior_is_inst_jr & jbr_taken) ? jbr_target : 
//                 predict_jbr_taken ? predict_jbr_target : seq_pc;

    always @(posedge clk)    // PC���������
    begin
        if (!resetn)
        begin
            pc <= `STARTADDR; // ��λ��ȡ������ʼ��ַ
        end
        else if (next_fetch)
        begin
            pc <= next_pc;    // ����λ��ȡ��ָ��
        end
    end
//-----{���������PC}end

//-----{����inst_rom��ȡָ��ַ}begin
    assign inst_addr = pc;
//-----{����inst_rom��ȡָ��ַ}end

//-----{IFִ�����}begin
    //����ָ��romΪͬ����д��,
    //ȡ����ʱ����һ����ʱ
    //������ַ����һ��ʱ�Ӳ��ܵõ���Ӧ��ָ��
    //��ȡָģ����Ҫ����ʱ��
    //��ÿ��PCˢ�£�IF_over��Ҫ��0
    //Ȼ��IF_valid����һ�ļ���IF_over�ź�
    assign IF_over = IF_valid;
//    always @(*) begin
//        IF_over = IF_valid;
//    end
//    always @(posedge clk)
//    begin
//        if (!resetn || next_fetch)
//        begin
//            IF_over <= 1'b0;
//        end
//        else
//        begin
//            IF_over <= IF_valid;
//        end
//    end
    //���ָ��romΪ�첽���ģ���IF_valid����IF_over�źţ�
    //��ȡָһ�����
//-----{IFִ�����}end

//-----{IF->ID����}begin
    assign IF_ID_bus = {pc, inst};  // ȡָ����Чʱ������PC��ָ��
   //assign IF_ID_bus = (~jbr_taken & prior_predict_jbr_taken) | (prior_is_inst_jr & jbr_taken) ? {64'h0} : {pc, inst};
//-----{IF->ID����}end

//-----{չʾIFģ���PCֵ��ָ��}begin
    assign IF_pc   = pc;
    assign IF_inst = inst;
//-----{չʾIFģ���PCֵ��ָ��}end


endmodule