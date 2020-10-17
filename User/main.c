#define USE_STDPERIPH_DRIVER
#define STM32F10X_HD
#include "stm32f10x.h"
#include "stm32f10x_conf.h"
#include "stm32f10x_adc.h"

int main(){
  // 打开 GPIOB 端口的时钟
	*( unsigned int * )0x40021018 |=  ( (1) << 3 );
	
	// 配置IO口为输出
	*( unsigned int * )0x40010C00 &=  ~( (0x0f) << (4*0) );
	*( unsigned int * )0x40010C00 |=  ( (1) << (4*0) );
	
	// 控制 ODR 寄存器
	*( unsigned int * )0x40010C0C &= ~(1<<0); 
    RCC->CIR = 0x0001;
	
	
	//ADC_InitTypeDef ADC_InitType;  
	//ADC_InitType.ADC_ContinuousConvMode =;
	//ADC_Init()


}
void SystemInit(){

    return ;
}

