import { mapState } from 'vuex'
import store from '@/store'

// 尝试将用户在根目录中的store/index.js的vuex的state变量加载到全局变量中
let $tStoreKey = []
try {
  $tStoreKey = store.state ? Object.keys(store.state) : []
} catch(e) {
  
}

module.exports = {

  computed: {
    // 将vuex的state中的变量结构到全局混入mixin中
    ...mapState($tStoreKey)
  }
}