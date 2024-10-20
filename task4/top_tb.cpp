#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;


    Verilated::commandArgs(argc, argv);
    // init top verilog instance
    Vtop* top = new Vtop;
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp,99);
    tfp->open ("counter.vcd");

    //init vbuddy
    if (vbdOpen() !=1) return(-1);
    vbdHeader("Lab 1: Counter");

    //initialize
    top->clk = 1;
    top->rst = 1;
    top->en = 0;


    //run simulation fpr many clock cycles
    for (i=0; i<1000; i++) {
        //dump variables in VCD file and toggle clock
        for (clk=0; clk<2; clk++) {
            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();

        }
        
        //send count value to Vbuddy
        vbdPlot(int(top->count), 0, 255);

        

        vbdCycle(i+1);
        // end of Vbuddy iutput section

        //change input stimuli
        top->rst = 0;
        top->en = 1;
        if (Verilated::gotFinish()) exit(0);

    }

    vbdClose();
    tfp->close();
    exit(0);
    

}