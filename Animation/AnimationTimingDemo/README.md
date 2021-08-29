# AnimationTimingDemo
--示例中描述了动画的timeoffset、begintime和speed的作用
</br>
## 动画
动画本质上就是一帧帧的静态图片连续播放。普通iOS设备每隔1/60s播放一帧。所以动画的关键就是：如何知道下一帧图片是怎样的。
假设一个6秒的动画，应该是由360帧组成。当动画加到layer后，随着时间的流逝，系统会实时计算出每一帧的内容来显示。这360帧图片与时间的关系可以想象成在X-Y坐标系中的一个函数。X轴是时间，Y轴是每一帧画面。动画就是在该坐标系中的函数。如下图</br>
![](https://github.com/electrmc/AnimationTimingDemo/blob/master/%E5%8A%A8%E7%94%BB.png)</br>
只要知道t1时间，就可以得到该时刻需要显示帧画面。因此，想要控制动画的进度就变成：时间的控制。

## 控制时间来控制动画
假设想让一个6秒的动画直接从第3秒开始。从帧-时间函数可知，关键就是如何得到正确的时间t1。以下是时间换算公式：</br>
#### 父图层和图层本地的时间换算公式 : t = (tp - beginTime) * speed + timeOffset</br>

t(active local time)是图层的本地时间， tp( parent layer time)是父图层的时间。X轴的原点是动画添加到layer上时的tp的时间，暂时称为t(add)时间。通常begintime=0.0，timeoffset=0.0，speed=1.0时，t(add)=tp，
如果我们没有改动的tp时间的话，此时tp应该是系统的绝对时间，即CACurrentMediaTime()。
## beginTime
begintime的改变分为动画添加到layer前和添加到layer后，begintime的值可正可负。2*2一共四种情况。假设speed=1.0，timeoffset=0.0，则t = tp - beginTime，以下对着四种情况分别说明：</br>
#### 1 动画添加到layer前， begintime>0
当将动画添加到layer时刻，动画的local active time < t(add)时间。需要再经过begintime后，local active time到达t(add)时间时动画才会进行，也就是动画会延时执行。</br>
#### 2 动画添加到layer前， begintime<0 ：</br>
当将动画添加到layer时刻，动画的loacl active time > t(add)时间。就相当于动画已经进行了值为begintime的时间。此时动画就会从中间的某一帧开始。此时应该区别于设置timeoffset。</br>
#### 3 动画添加到layer后， begintime>0 ：</br>
此时动画正在进行中，突然加大了begintime，就想当与X轴上的值突然往左移动了，表现就是动画会突然回到原来的某一帧继续开始。相当于后退。</br>
#### 4 动画添加到layer后， begintime<0 ：</br>
很明显，减小begintime，动画就相当于前进。</br>
最后需要注意的是：</br>
1. speed决定begintime的影响。当speed为0时，begintime无论怎么改变都不会影响loacl active time，此时loacl active time=timeoffset。因此，想要通过改变begintime对动画进行延时，快进，快退，speed必须要大于0。</br>
2. begintime的取值应该小于动画的duration/speed。超过这个范围后，动画已经结束，这时改变不会再有影响。</br>
## timeoffset
相比begintime必须在speed大于0的情况下有作用，timeoffset一般会在speed等于0的情况下起作用。
当speed等于0时，t = timeoffset。这时，只需要改变timeoffset就可以控制动画的进度。不过这里需要注意的是timeoffset的取值。X轴上t1 = t(add) + |t1-t(add)|</br>
1. 当动画以speed=1.0的速度开始后。假设begintime = 0.0，X轴的原点：t(add) = tp。</br>
2. 当动画开始时speed=0.0，那么X轴的原点t(add) = 0。</br>
## 总结
begintime在speed>0时可以实现动画快退、快进以及延时开始的功能。timeoffset在speed=0.0时，可以实现手动控制动画的进程。
