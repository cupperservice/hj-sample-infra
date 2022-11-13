const aws = require('aws-sdk')
const sharp = require('sharp')

const S3 = new aws.S3()

exports.handler = async (event, context) => {
  console.log("start create thumbnail function!!!")
  const image = await downloadImage(
    event.s3.original.bucket_name,
    event.s3.original.key
  )

  const thumbnail = await createThumbnail(image)

  const result = await uploadImage(
    event.s3.thumbnail.bucket_name,
    event.s3.original.key,
    thumbnail)

  console.log('finished create thumbnail function!!!')
  return result
}

const downloadImage = (bucket, key) => {
  return new Promise((resolve, reject) => {
    S3.getObject({
      Bucket: bucket,
      Key: key
    }, (err, data) => {
      if (err) reject(err)
      else resolve(data.Body)
    })
  })
}

const createThumbnail = (input) => {
  return sharp(input).resize(100, 100).toBuffer()
}

const uploadImage = (bucket, key, input) => {
  return new Promise((resolve, reject) => {
    S3.upload({
      Bucket: bucket,
      Key: key,
      Body: input,
      ContentType: 'image/png'
    }, (err, data) => {
      if (err) reject(err)
      else resolve(data)
    })
  })
}
