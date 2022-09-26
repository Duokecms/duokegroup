### 组件说明

- 此组件是根据官方组件（hello-uniapp/pages/template/crop/crop.vue）优化而成，组件化；
- 目的是为了方便之后的使用；
- 希望此项目可以给各位老板提供一些思路，或者直接使用；
- 欢迎各位老板评论、收藏，指教；如果有问题会不定时更新；
- 长期更新。

### 参数说明
|            参数             |    类型     | 必填 | 默认值        | 说明                                             |
| :-------------------------: | :---------: | :--: | ------------- | ------------------------------------------------ |
|            fixed            |   Boolean   |  否  | true          | 固定比例（优先级高于cropWidth、cropHeight，如果设置固定比例则直接使用比例计算）|
|         fixedNumber         |    Array    |  否  | [1,1]         | [宽:高]比例数组（优先级高于cropWidth、cropHeight，如果设置固定比例则直接使用比例计算）|
|          cropWidth          |   Number    |  否  | 200           | 裁剪框初始化宽度（px）                           |
|         cropHeight          |   Number    |  否  | 200           | 裁剪框初始化高度（px）                           |
|          minWidth           |   Number    |  否  | 20            | 最小宽度（px）                                   |
|          minHeight          |   Number    |  否  | 20            | 最小高度（px）                                   |
|         saveLoading         |   String    |  否  | 图片生成中...   | 生成/上传图片时的loading文字                     |
|      selectButtonText       |   String    |  否  | 选择照片        | 选择照片的按钮文字                               |
|      selectButtonColor      |   String    |  否  | #FFFFFF       | 选择照片的按钮文字颜色                           |
| selectButtonBackgroundColor |   String    |  否  | #FF2E80       | 选择照片的按钮背景颜色                           |
|       saveButtonText        |   String    |  否  | 上传           | 上传的按钮文字                                   |
|       saveButtonColor       |   String    |  否  | #FFFFFF       | 上传的按钮文字颜色                               |
|  saveButtonBackgroundColor  |   String    |  否  | #FF2E80       | 上传的按钮背景颜色                               |
|  image  					  |   String    |  否  | ''            | 默认图片                               |
|  maxCropper  				  |   Boolean   |  否  | false         | 打开时是够默认最大尺度展示裁剪框           |
|  fileType  			      |   String    |  否  | 'jpg'         | 目标文件的类型，只支持 'jpg' 或 'png'。默认为 'jpg'|
|  quality  				  |   Number    |  否  | 1             | 图片的质量，取值范围为 (0, 1]，不在范围内时当作1.0处理（微信小程序：目前仅对 jpg 有效）|
|  original  				  |   Boolean   |  否  | true          | 是否按照原始大小返回|
|       @uploadSuccess        | EventHandle |  是  | --            | 点击上传按钮时的触发，参数即为裁剪图片的临时地址 |

### 使用方法

#### 导入插件

使用 HBuilderX 导入插件

#### 代码使用

```vue
<template>
	<view>
		<okingtz-cropper @uploadSuccess="uploadSuccess"></okingtz-cropper>
	</view>
</template>

<script>
  //  1.引入项目
  import OkingtzCropper from '@/uni_modules/okingtz-cropper/components/okingtz-cropper/okingtz-cropper'
  export default {
		components:{
			//2.使用组件
			OkingtzCropper
		},
		methods: {
			// 3.定义自己的回调函数
			uploadSuccess(tempFilePath){
				uni.showToast({
					title:'保存成功'
				})
				// 4.根据自己的业务场景处理tempFilePath ;接口保存，或者上传至云空间
				console.log('tempFilePath_->',tempFilePath)
			}
		}
	}
</script>
```




